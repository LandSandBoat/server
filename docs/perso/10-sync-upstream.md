# Suivre le depot officiel

## Modele

Un seul depot : ton fork de `LandSandBoat/server`.

```
origin    -> github.com/<toi>/server          (ton fork)
upstream  -> github.com/LandSandBoat/server   (officiel, lecture seule)
```

- `upstream/base` : la branche de developpement officielle.
- `main` : ta branche de travail, jamais poussee vers upstream.

## Regle qui evite les conflits

**Tout ce qui est a toi vit dans des chemins qui n'existent pas chez upstream.**

| Chemin | Contenu |
|---|---|
| `deploy/` | compose, `.env`, SQL d'exploitation, scripts |
| `modules/jsl/` | modules Lua / SQL maison |
| `docs/` | cette documentation |

Un fichier ajoute ne peut pas entrer en conflit. Les seuls fichiers du coeur
que tu modifies devraient etre :

- `modules/init.txt` (une ligne ajoutee) — conflit trivial le cas echeant
- du C++ dans `src/` — seulement quand un module ne suffit pas

## Mise a jour

```powershell
git checkout main
.\deploy\sync-upstream.ps1            # apercu
.\deploy\sync-upstream.ps1 -Merge     # fusion

cd deploy
docker compose build
docker compose up -d                  # database-update applique les migrations
```

Fusion (`merge`) plutot que `rebase` : la branche est longue duree et publiee,
un rebase reecrirait l'historique a chaque synchronisation.

## Avant de fusionner, regarder

- `sql/` : nouveaux fichiers = migrations que `dbtool update` va appliquer
- `settings/default/` : nouveaux reglages a reporter dans tes surcharges
- `modules/module_utils.lua` : changements de l'API des modules
- les fonctions que tes modules surchargent — si upstream renomme
  `InteractionGlobal.onZoneIn`, ton override devient silencieusement mort.
  Les logs au demarrage listent chaque override applique.

## Sauvegarde avant chaque synchronisation

```powershell
docker compose run --rm database-update python /server/tools/dbtool.py backup
```
