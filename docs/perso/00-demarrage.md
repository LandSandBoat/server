# Demarrage

## Prerequis

- Docker Desktop (WSL2) avec `docker compose`
- Git
- Un client FFXI installe + un loader (Ashita v4 ou Windower)
- ~15 Go d'espace disque et un premier build de 20 a 40 minutes

## 1. Configuration

```powershell
cd deploy
copy .env.example .env
notepad .env
```

`XI_ZONE_IP` est le reglage qui casse le plus souvent une premiere installation :
c'est l'adresse que le lobby **renvoie au client** pour joindre les serveurs de
zone. Elle doit etre joignable depuis la machine qui joue.

| Situation | Valeur |
|---|---|
| Le jeu tourne sur la meme machine que Docker | `127.0.0.1` |
| Une autre machine du LAN | l'IP LAN de l'hote, ex. `192.168.1.42` |
| Depuis Internet | l'IP publique, + redirection de ports sur le routeur |

## 2. Construction et demarrage

```powershell
docker compose build          # long la premiere fois, puis mis en cache
docker compose up -d
docker compose logs -f map
```

Ordre d'execution : `database` (healthy) puis `database-update` (import + migrations,
plusieurs minutes au premier lancement) puis `zone-ip` puis `connect` / `search` /
`world` / `map`.

## 3. Verifications

```powershell
docker compose ps                       # tout doit etre « running » / « exited (0) »
docker compose logs database-update     # doit finir sans erreur
curl http://localhost:8088/api/health   # API du world server
```

## 4. Compte de jeu

`ACCOUNT_CREATION` est a `true` dans `settings/default/login.lua` : le compte se cree
directement depuis le loader, au premier essai de connexion.

Pour se donner les droits GM ensuite :

```sql
UPDATE chars SET gmlevel = 5 WHERE charname = 'MonPerso';
```

## 5. Client

Pointer le loader vers l'hote Docker :

- **Ashita v4** : `config/boot/*.json`, champ `server`
- **Windower** : profil, champ `server`

`CLIENT_VER` dans `settings/default/login.lua` doit correspondre a la version du
client ; `VER_LOCK = 2` accepte une version egale ou plus recente.

## Ports

| Port | Protocole | Service |
|---|---|---|
| 54001 | TCP | connect (view) |
| 54002 | TCP | search |
| 54230 | TCP | connect (data) |
| 54230 | UDP | map |
| 54231 | TCP | connect (auth) |
| 8088 | TCP | world (API HTTP) |
