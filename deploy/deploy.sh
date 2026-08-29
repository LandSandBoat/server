#!/usr/bin/env bash
# ---------------------------------------------------------------------------
# Deploiement d'une version sur le serveur de production.
#
#   bash deploy/deploy.sh <image:tag> [commit-sha]
#
# Appele par le workflow GitHub Actions « Deploy prod », mais utilisable a la
# main pour un deploiement ou un retour arriere :
#
#   bash deploy/deploy.sh ghcr.io/sekaroo/landsandboatserver:a1b2c3d4e5f6
#
# Etapes : synchronisation du depot, pull de l'image, sauvegarde des donnees
# joueurs, migrations, redemarrage, controle de sante. Si le controle echoue,
# le script remet automatiquement l'image precedente.
# ---------------------------------------------------------------------------
set -Eeuo pipefail

IMAGE="${1:?usage: deploy.sh <image:tag> [commit-sha]}"
SHA="${2:-}"

cd "$(dirname "${BASH_SOURCE[0]}")/.."
ROOT="$PWD"

COMPOSE=(docker compose
    -f deploy/docker-compose.yml
    -f deploy/docker-compose.prod.yml
    --env-file deploy/.env)

log()  { printf '\n\033[36m==> %s\033[0m\n' "$*"; }
warn() { printf '\033[33m%s\033[0m\n' "$*"; }
die()  { printf '\033[31m%s\033[0m\n' "$*" >&2; exit 1; }

[[ -f deploy/.env ]] || die "deploy/.env est absent. Copie deploy/.env.prod.example et remplis-le."

mkdir -p backups log

# --- Image actuellement en service, pour le retour arriere ----------------
PREVIOUS=""
if cid=$("${COMPOSE[@]}" ps -q map 2>/dev/null) && [[ -n "$cid" ]]; then
    PREVIOUS=$(docker inspect --format '{{.Config.Image}}' "$cid" 2>/dev/null || true)
fi
[[ -n "$PREVIOUS" ]] && log "Version en service : $PREVIOUS" || log "Aucune version en service (premier deploiement)"

# --- Synchronisation du depot ---------------------------------------------
# Les fichiers compose, les scripts Lua montes et le SQL doivent correspondre
# exactement au commit dont l'image a ete construite.
if [[ -n "$SHA" ]]; then
    log "Synchronisation du depot sur $SHA"
    git fetch --prune origin
    git checkout --detach --force "$SHA"
fi

# --- Recuperation de l'image ----------------------------------------------
log "Recuperation de $IMAGE"
docker pull "$IMAGE"

export SERVER_IMAGE="$IMAGE"

# --- Sauvegarde des donnees joueurs ---------------------------------------
# « lite » ne sauvegarde que les tables joueurs : tout le reste est
# reconstructible depuis sql/. C'est rapide, et c'est exactement ce qu'une
# migration ratee pourrait abimer.
log "Sauvegarde des donnees joueurs"
"${COMPOSE[@]}" up -d database
"${COMPOSE[@]}" run --rm --no-deps -T database-update \
    python /server/tools/dbtool.py backup lite
ls -1t backups/ 2>/dev/null | head -1 | sed 's/^/    derniere sauvegarde : /'

# Rotation : on garde les 20 plus recentes.
if compgen -G "backups/*.sql" >/dev/null; then
    ls -1t backups/*.sql | tail -n +21 | xargs -r rm -f
fi

# --- Migrations et redemarrage --------------------------------------------
log "Migrations et redemarrage"
"${COMPOSE[@]}" up -d --remove-orphans

# --- Controle de sante -----------------------------------------------------
log "Controle de sante"
healthy=0
for _ in $(seq 1 60); do
    sleep 5

    running=$("${COMPOSE[@]}" ps --status running --services 2>/dev/null | sort -u)
    for svc in connect search world map; do
        grep -qx "$svc" <<<"$running" || continue 2
    done

    "${COMPOSE[@]}" logs --tail 200 map 2>/dev/null | grep -q "ready to work" || continue

    if command -v curl >/dev/null; then
        curl -fsS --max-time 5 "http://127.0.0.1:8088/api" >/dev/null || continue
    fi

    healthy=1
    break
done

if (( healthy )); then
    log "Deploiement reussi : $IMAGE"
    printf '%s\n' "$IMAGE" > deploy/.last-deployed
    docker image prune -f --filter "until=168h" >/dev/null 2>&1 || true
    exit 0
fi

# --- Retour arriere --------------------------------------------------------
warn "Controle de sante echoue apres 5 minutes."
"${COMPOSE[@]}" logs --tail 60 map || true

if [[ -z "$PREVIOUS" || "$PREVIOUS" == "$IMAGE" ]]; then
    die "Pas de version precedente vers laquelle revenir. Le serveur est arrete ou instable."
fi

warn "Retour a $PREVIOUS"
export SERVER_IMAGE="$PREVIOUS"
"${COMPOSE[@]}" up -d
die "Deploiement annule, $PREVIOUS remis en service. La sauvegarde est dans backups/."
