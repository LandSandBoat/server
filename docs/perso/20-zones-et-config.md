# Repartir les zones et differencier leur configuration

## Ce que Docker permet reellement

`xi_map` est **mono-thread**. Un serveur = plusieurs processus `xi_map`, chacun
servant un sous-ensemble de zones. L'aiguillage se fait en base :

```
zone_settings(zoneid, zoneip, zoneport, name)
```

Toutes les zones pointent par defaut sur `zoneport = 54230`. Changer le
`zoneport` d'une zone la fait servir par le processus qui ecoute sur ce port.
Le lobby et les autres processus lisent cette table, la transition est
transparente pour le joueur.

Chaque conteneur `xi_map` charge **son propre jeu de settings** (`XI_MAP_*`).
C'est la que se trouve la vraie capacite « configuration differente par zone » :
un processus dedie aux villes peut avoir son propre `SPEED_LIMIT`, `EXP_RATE`,
`DROP_RATE_MULTIPLIER`, etc.

## Deux leviers, deux usages

| Besoin | Bon outil |
|---|---|
| Repartir la charge CPU | plusieurs `xi_map` |
| Reglage global different pour un **groupe** de zones | plusieurs `xi_map` + `XI_MAP_*` |
| Regle de gameplay ciblee (une zone, une condition, un joueur) | **module Lua** |

Important : le decoupage en processus est un outil de **capacite**, pas de
gameplay. Pour « plus vite en ville », le module Lua
`modules/jsl/lua/city_move_speed.lua` est le bon outil : il fonctionne quel que
soit le decoupage, ne coute pas un processus supplementaire, et se teste sans
toucher a la base.

## Mise en place du decoupage villes

```powershell
cd deploy

# 1. La base doit exister
docker compose up -d database

# 2. Aiguiller les zones de ville vers 54232
docker compose exec -T database `
  mariadb -u xiadmin -p"<mot de passe>" xidb < sql\zone-split-cities.sql

# 3. Demarrer avec le second processus map
docker compose -f docker-compose.yml -f docker-compose.zones.yml up -d
```

Verification :

```sql
SELECT zoneport, COUNT(*) FROM zone_settings GROUP BY zoneport;
```

Retour arriere : `sql/zone-split-reset.sql`, puis relancer sans le fichier
`docker-compose.zones.yml`.

## Cout reel

Chaque processus `xi_map` charge sa part du monde en memoire. Compter environ
1 a 2 Go par processus. En dessous d'une centaine de joueurs simultanes, un
seul `xi_map` suffit largement — le decoupage se justifie surtout pour isoler
une configuration, pas pour les performances.

## Limites a connaitre

- Les ports supplementaires doivent etre ouverts en **UDP** (54232, 54233, ...)
  et joignables a l'adresse `XI_ZONE_IP`.
- Un joueur qui traverse la frontiere entre deux processus est recree cote
  serveur : les variables locales et les mods ajoutes par script sont remis a
  zero. Les modules doivent donc reappliquer leur effet a l'entree de zone —
  c'est ce que fait `city_move_speed.lua`.
- Les instances (Dynamis, battlefields) restent sur le processus de leur zone.
