# Certbot

## What’s Certbot?

Certbot is a free, open source software tool for automatically using [Let’s Encrypt](https://letsencrypt.org/).

Certbot is made by the [Electronic Frontier Foundation (EFF)](https://www.eff.org/), a 501(c)3 nonprofit based in San Francisco, CA, that defends digital privacy, free speech, and innovation.

## Requirements
Certbot needs a way to verify ownership of your server's hostname or domain. The default method for this is to run a service on port 80 of your server during the registration and renewals processes. This may require opening an additional port on your firewall. If you are running a Apache or Nginx on the same server as `xi_connect`, you can use those for validation instead or even skip to the renewal-hook section to share the certificate between an existing service and `xi_connect`. You can also use DNS providers such as AWS Route 53. This guide will attempt to cover each of these methods.

Make sure you replace any references to `/path/to/server/` with your own server's path.

## Install Certbot
<details>
  <summary>Linux (Ubuntu 24.04)</summary>

### Backup Existing Cert
Chances are you already have a cert in your xi server directory. The connect server will automatically generate a self-signed certificate if it does not detect one. Its a good idea to back anything we are changing just in case.
```sh
cp /path/to/server/login.key /path/to/server/login.key.bak
cp /path/to/server/login.cert /path/to/server/login.cert.bak
```

### To Install
Run these steps to use Certbot's community provided installation:
https://certbot.eff.org/instructions?ws=other&os=pip
or follow the commands below:
```sh
$ sudo apt update
$ sudo apt install python3 python3-venv libaugeas0
$ sudo python3 -m venv /opt/certbot/
$ sudo /opt/certbot/bin/pip install --upgrade pip
$ sudo /opt/certbot/bin/pip install certbot
```
##### For Apache:
```sh
$ sudo /opt/certbot/bin/pip install certbot-apache
```
##### For Nginx:
```sh
$ sudo /opt/certbot/bin/pip install certbot-nginx
```
##### For AWS Route53
```sh
$ sudo /opt/certbot/bin/pip install certbot-dns-route53
```
> ##### Additional steps are required for AWS Route53:
>* Log into your AWS console and generate an access and secret key.
>
>* Configure your AWS Route 53 Credentials:
>
>```sh
>$ sudo su -
># mkdir /root/.aws
>```
>
>Create a file in /root/.aws called `config`
>```sh
>[default]
>region = us-east-1
>```
>Create a file in /root/.aws called `credentials`
>```sh
>[default]
>aws_access_key_id = <AWS_ACCESS_KEY_ID>
>aws_secret_access_key = <AWS_SECRET_ACCESS_KEY>
>```

Run the command for your environment to generate your Letsencrypt certificate:
##### Default
```sh
$ sudo certbot certonly --key-type rsa -d myserver.mydomain.com
```
##### Apache
```sh
$ sudo certbot certonly --key-type rsa --apache -d myserver.mydomain.com
```
##### Nginx
```sh
$ sudo certbot certonly --key-type rsa --nginx -d myserver.mydomain.com
```

##### AWS Route53
```sh
$ sudo certbot certonly --key-type rsa --dns-route53 -d myserver.mydomain.com
```

### Create a post-renewal script
Create the following Certbot post-renewal in:
`/etc/letsencrypt/renewal-hooks/post/xi_connect.sh`
with the following contents:
```sh#!/bin/bash
#!/bin/bash
cp /etc/letsencrypt/live/myserver.mydomain.com/privkey.pem /path/to/server/login.key
cp /etc/letsencrypt/live/myserver.mydomain.com/fullchain.pem /path/to/server/login.cert
chown xiuser:xiuser /path/to/server/login.key /path/to/server/login.cert
systemctl restart xi_connect.service
```
Make the post-renewal script executable and run it:
```sh
$ sudo chmod u+x /etc/letsencrypt/renewal-hooks/post/xi_connect.sh
$ sudo /etc/letsencrypt/renewal-hooks/post/xi_connect.sh
```
Check the xi_connect log for any errors. If done correctly, the `connect-server.log` file should look something like:
```sh
[12/19/24 00:49:11:626][connect][info] The connect-server is ready to work... (Application:70)
[12/19/24 00:49:11:626][connect][info] ======================================================================= (Application:71)
[12/19/24 00:49:11:626][connect][info] Seeding Mersenne Twister 32 bit RNG (seed:39)
[12/19/24 00:49:11:628][connect][info] Found existing login.key (generateSelfSignedCert:38)
[12/19/24 00:49:11:628][connect][info] Found existing login.cert: /C=US/O=Let's Encrypt/CN=R10 (generateSelfSignedCert:57)
[12/19/24 00:49:11:628][connect][info] creating ports (ConnectServer:77)
[12/19/24 00:49:11:632][connect][info] starting io_context (ConnectServer:89)
```
</details>
