# Installer le runner sur le serveur de production

A faire une seule fois. Le resultat : un utilisateur dedie, un runner
enregistre sous le label `lsb`, demarre automatiquement au boot par systemd.

Toutes les commandes sont a passer sur le serveur, depuis un compte capable de
`sudo`.

> **Prealable.** Active les Actions sur le fork avant de commencer : onglet
> Actions du depot, bouton de confirmation. Elles sont eteintes par defaut sur
> tout fork, et tant qu'elles le sont l'enregistrement d'un runner echoue avec
> un `404` qui n'explique rien.

## 1. L'utilisateur dedie

Le runner execute du code venu de GitHub : il ne doit pas tourner sous ton
compte personnel, ni sous root.

```bash
sudo useradd --create-home --shell /bin/bash \
     --comment "GitHub Actions runner (FFXI)" ffxi

# Pas de mot de passe : on n'y accede que via sudo.
sudo passwd --lock ffxi
```

Il lui faut acces au demon Docker :

```bash
getent group docker || sudo groupadd docker
sudo usermod --append --groups docker ffxi
```

**A savoir :** appartenir au groupe `docker` equivaut a un acces root sur la
machine — on peut monter n'importe quel repertoire de l'hote dans un
conteneur privilegie. C'est inherent au fait de deployer avec Docker, mais
autant le savoir plutot que le decouvrir. C'est aussi la raison pour laquelle
cet utilisateur n'a pas de droits `sudo` et sert **uniquement** a cela.

## 2. Telecharger le runner

```bash
sudo -u ffxi -i          # on bascule sur le compte dedie
mkdir -p ~/actions-runner && cd ~/actions-runner

VERSION=$(curl -fsSL https://api.github.com/repos/actions/runner/releases/latest \
          | sed -n 's/.*"tag_name": *"v\([^"]*\)".*/\1/p')
echo "Version : ${VERSION}"

curl -fsSLo runner.tar.gz \
  "https://github.com/actions/runner/releases/download/v${VERSION}/actions-runner-linux-x64-${VERSION}.tar.gz"
tar xzf runner.tar.gz && rm runner.tar.gz
exit                     # retour au compte sudo
```

Dependances systeme (libicu et compagnie) :

```bash
sudo /home/ffxi/actions-runner/bin/installdependencies.sh
```

## 3. Enregistrer le runner

Recupere un jeton d'enregistrement : depot > Settings > Actions > Runners >
**New self-hosted runner** > Linux. Le jeton affiche est **valable une heure**
et a usage unique — genere-le juste avant de lancer `config.sh`, pas en
preparant le terrain.

L'`--url` est celle du depot, **sans** `.git` et sans barre oblique finale.
Elle doit correspondre au niveau auquel le jeton a ete emis : un jeton pris
sur la page Runners d'une organisation ne fonctionne pas avec une URL de
depot, et inversement.

```bash
sudo -u ffxi -i
cd ~/actions-runner

./config.sh \
  --url    https://github.com/<toi>/<depot> \
  --token  <JETON> \
  --name   lsb-prod \
  --labels lsb \
  --work   _work \
  --unattended --replace

exit
```

`config.sh` refuse de s'executer en root, c'est voulu.

Le label `lsb` est celui que cible le `runs-on` du workflow. Les labels
`self-hosted`, `Linux` et `X64` sont ajoutes automatiquement, inutile de les
lister.

## 4. Demarrage automatique au boot

A lancer depuis ton compte habituel (celui qui a `sudo`), **pas** depuis
`ffxi` : ce dernier n'a volontairement aucun droit `sudo`.

```bash
sudo bash -c 'cd /home/ffxi/actions-runner && ./svc.sh install ffxi'
sudo bash -c 'cd /home/ffxi/actions-runner && ./svc.sh start'
sudo bash -c 'cd /home/ffxi/actions-runner && ./svc.sh status'
```

Le `cd` est place **dans** le `sudo` a dessein : `/home/ffxi` est en mode 750,
ton compte ne peut donc pas y entrer, alors que root traverse sans probleme.
Et `svc.sh` exige a la fois d'etre root et d'etre lance depuis son propre
repertoire.

`svc.sh install` cree **et active** une unite systemd nommee
`actions.runner.<proprietaire>-<depot>.lsb-prod.service`. L'activation suffit
au demarrage automatique, il n'y a rien d'autre a faire.

Verifications :

```bash
systemctl is-enabled 'actions.runner.*'    # doit repondre « enabled »
systemctl is-active  'actions.runner.*'    # doit repondre « active »
journalctl -u 'actions.runner.*' -f        # journal en direct
```

Dans l'interface GitHub, le runner doit maintenant apparaitre **Idle** avec le
label `lsb`.

Les autres commandes de gestion suivent la meme forme :
`sudo bash -c 'cd /home/ffxi/actions-runner && ./svc.sh stop'`, idem avec
`uninstall`.

## 5. Le repertoire de deploiement

Il est distinct du repertoire du runner : le runner ne fait qu'appeler le
script qui s'y trouve.

```bash
sudo mkdir -p /srv/ffxi-server
sudo chown ffxi: /srv/ffxi-server
sudo -u ffxi git clone https://github.com/<toi>/<depot>.git /srv/ffxi-server

sudo -u ffxi -i
cd /srv/ffxi-server
cp deploy/.env.prod.example deploy/.env
$EDITOR deploy/.env       # mots de passe + XI_ZONE_IP = adresse LAN du serveur
chmod 600 deploy/.env
mkdir -p backups log
exit
```

Si tu choisis un autre chemin, declare-le dans la variable de depot
`DEPLOY_PATH` (Settings > Secrets and variables > Actions > Variables).

## 6. Mettre a jour le runner

Le runner se met a jour tout seul tant que la version installee reste
compatible. Quand GitHub finit par la refuser, le journal le dit clairement :

```bash
sudo bash -c 'cd /home/ffxi/actions-runner && ./svc.sh stop'

sudo -u ffxi -i
cd ~/actions-runner
# rejouer l'etape 2 (telechargement), puis :
exit

sudo bash -c 'cd /home/ffxi/actions-runner && ./svc.sh start'
```

L'enregistrement survit, il n'y a pas besoin d'un nouveau jeton.

## Symptomes et causes

| Symptome | Cause |
|---|---|
| Le job `deploy` reste en attente sans erreur | Aucun runner ne porte le label `lsb`, ou le runner est hors ligne. GitHub ne signale rien, il attend. |
| `permission denied` sur `/var/run/docker.sock` | L'ajout au groupe `docker` date d'apres le demarrage du service. `sudo systemctl restart 'actions.runner.*'` |
| `deploy.sh: Permission denied` sur `deploy/.env` | Le repertoire de deploiement n'appartient pas a `ffxi`. |
| Le runner passe *Offline* apres un reboot | `svc.sh install` n'a pas ete lance, ou l'unite a ete desactivee. Verifie `systemctl is-enabled`. |
| `config.sh` refuse de demarrer | Il est lance en root. Repasse par `sudo -u ffxi -i`. |
| `cd /home/ffxi/... : Permission denied` | Le home de `ffxi` est en 750. Passe par `sudo bash -c 'cd ... && ...'` plutot que de faire le `cd` toi-meme. |
| `sudo` demande un mot de passe a `ffxi` | Normal : ce compte est verrouille et n'a pas `sudo`. Les commandes privilegiees se lancent depuis ton compte habituel. |
| `config.sh` : `404 (Not Found)` sur `runner-registration` | Le couple URL + jeton ne resout rien de valide. Dans l'ordre : **Actions non activees sur le fork** (voir le prealable en haut) ; jeton perime (une heure) ou deja consomme ; jeton tronque au collage ; `--url` erronee (`.git` en trop, gabarit non remplace) ; jeton emis a un autre niveau que l'URL. Verifie l'URL avec `curl -s -o /dev/null -w '%{http_code}\n' <url>` — un depot public repond 200. |
