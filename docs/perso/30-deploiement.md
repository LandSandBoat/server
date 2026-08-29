# Deploiement en production

## Le flux

```
push sur main        -> build de l'image, publication sur GHCR
                        (verifie que ca compile, ne deploie pas)

git tag v1.2.3       -> build + publication
   + git push --tags -> le runner auto-heberge, sur le serveur de jeu :
                        sync du depot, pull, sauvegarde, migrations,
                        redemarrage, controle de sante
                        -> si le controle echoue, retour automatique
                           a l'image precedente
```

Le serveur n'a pas d'IP publique et n'en a pas besoin : le runner sort vers
GitHub, rien n'entre. Aucune cle SSH n'est deposee chez GitHub.

L'image est construite **une fois** et la meme est deployee. Le tag principal
est le SHA court du commit, donc chaque version est identifiable et
re-deployable ; un tag de version ajoute `v1.2.3` et `latest`.

## Avertissement : runner auto-heberge sur un depot public

Ton fork est public — un fork herite de la visibilite du parent et ne peut pas
etre bascule en prive. GitHub deconseille les runners auto-heberges sur les
depots publics, parce qu'une pull request venue de n'importe qui pourrait
faire executer du code sur ta machine.

Le workflow est ecrit pour fermer cette porte : il ne se declenche que sur
`push` (donc sur des references que seuls les comptes ayant les droits
d'ecriture peuvent modifier) et sur `workflow_dispatch`. **Jamais sur
`pull_request`.** Si tu ajoutes un declencheur un jour, garde cette regle.

Deuxieme verrou a poser, dans Settings > Actions > General :

- « Fork pull request workflows » : exiger une approbation pour tous les
  contributeurs externes
- « Require approval for all external contributors »

## Preparation, cote GitHub

1. **Activer les Actions sur le fork.** Onglet Actions, bouton de
   confirmation. Les workflows herites d'upstream ne se declencheront pas :
   `build.yml` et `test.yml` ne reagissent qu'a la branche `base`, et
   `pr_checks.yml` qu'aux pull requests. Ta branche est `main`.

2. **Le runner.** Son installation — creation de l'utilisateur dedie,
   enregistrement, demarrage automatique au boot — est decrite dans
   [31-runner.md](31-runner.md).

   Settings > Actions > Runners : il doit apparaitre en ligne avec le label
   `lsb`, celui que cible le `runs-on` du workflow. Si le label disparait ou
   est renomme, le job de deploiement restera en attente indefiniment sans
   message d'erreur — c'est le symptome a reconnaitre.

   L'utilisateur qui fait tourner le runner doit etre dans le groupe `docker`
   et pouvoir ecrire dans le repertoire de deploiement.

3. **Variable de depot** (Settings > Secrets and variables > Actions >
   onglet Variables) : `DEPLOY_PATH`, par exemple `/srv/ffxi-server`.
   Facultatif, le defaut est deja `/srv/ffxi-server`.

Aucun secret a creer. Le paquet GHCR peut rester prive : le runner
s'authentifie avec le `GITHUB_TOKEN` de l'execution.

## Preparation, cote serveur

L'utilisateur dedie, le runner et le repertoire de deploiement sont couverts
pas a pas dans [31-runner.md](31-runner.md).

**Ports a ouvrir** vers le serveur : TCP 54001, 54002, 54230, 54231 et
UDP 54230. L'API HTTP (8088) est liee a `127.0.0.1` et n'est pas exposee.

`XI_ZONE_IP` est le reglage a ne pas rater : c'est l'adresse que le lobby
renvoie aux clients, et elle doit etre joignable **depuis les machines qui
jouent**. Sur un serveur interne sans IP publique, c'est son adresse LAN.

## Premier deploiement

Le premier import de base prend plusieurs minutes et le controle de sante
attend au maximum 5 minutes. Amorce donc la base a la main une fois, apres
avoir laisse le pipeline publier une premiere image :

```bash
cd /srv/ffxi-server
echo "<PAT read:packages>" | docker login ghcr.io -u <toi> --password-stdin
SERVER_IMAGE=ghcr.io/<toi>/<depot>:latest docker compose \
  -f deploy/docker-compose.yml -f deploy/docker-compose.prod.yml \
  --env-file deploy/.env up -d
```

Ce `docker login` manuel n'est necessaire que pour cette amorce ; le pipeline
gere ensuite son authentification tout seul.

## Deployer et revenir en arriere

Deploiement normal :

```bash
git tag v1.0.0
git push origin v1.0.0
```

Ou, sans creer de tag : onglet Actions > Deploy prod > Run workflow, en
cochant « Deployer apres le build ».

Retour arriere, directement sur le serveur :

```bash
cd /srv/ffxi-server
bash deploy/deploy.sh ghcr.io/<toi>/<depot>:a1b2c3d4e5f6
```

Sans second argument, le depot n'est pas re-synchronise — pratique pour
revenir a une image anterieure sans toucher aux fichiers.

Le retour arriere automatique se declenche si, apres 5 minutes, un des quatre
processus n'est pas en marche, si le journal de `map` n'annonce pas
`ready to work`, ou si l'API du world ne repond pas. Le script remet alors
l'image precedente et sort en erreur : le workflow apparait en echec, ce qui
est le comportement voulu.

`deploy/.last-deployed` contient la derniere image validee.

## Sauvegardes

Chaque deploiement produit une sauvegarde `lite` dans `backups/` avant
d'appliquer les migrations : uniquement les tables joueurs, car tout le reste
se reconstruit depuis `sql/`. Les 20 plus recentes sont conservees.

Sauvegarde complete a la main :

```bash
docker compose -f deploy/docker-compose.yml -f deploy/docker-compose.prod.yml \
  --env-file deploy/.env run --rm --no-deps -T database-update \
  python /server/tools/dbtool.py backup
```

Les fichiers de `backups/` sont des dumps SQL ordinaires, a reinjecter avec
`mariadb` dans le conteneur `database`.

## Duree attendue

Le premier build compile tout : 40 minutes et plus sur un runner GitHub a
deux coeurs. Ensuite le cache ccache est reutilise et une modification Lua,
SQL ou de configuration se reconstruit en quelques minutes. Une modification
C++ se situe entre les deux.

Un commit dont le message contient `[skip ci]` ne declenche aucune execution.
