Topaz Next Docker
==========

This guide assumes you have Docker (https://www.docker.com/) installed on your machine.

## How to start the server

* Launch docker
* Pull the repo
* Open powershell or whatever terminal you're using and navigate to the topaz directory
* Type `docker-compose up -d` (the `-d` is optional and will free up -detach- the terminal)
* Wait till everything is complete. If you previously stopped or deleted the services then you may encounter `ERROR: The image for the service you're trying to recreate has been removed. If you continue, volume data could be lost. Consider backing up your data before continuing. Continue with the new image? [yN]`. You can enter `y` to force the install.

Note the zone IPs are not updated in the DB and will default to 127.0.0.1 so you will need to use the `--hairpin` option when connecting to the server.

## How to restart the Server/DB

The server runs in the "game" service and the database in the "db" service and will likely be named something like `topaz_game_1` similarly the database will be something like `topaz_db_1`. To see the names assigned to your services type `docker ps`. To restart them you can use the `docker restart` command such as `docker restart topaz_game_1`.

Alternatively you can stop and start individual services with `docker stop conainer_name` and `docker start container_name` where `container_name` is the container name from the `docker ps` command. The run order should be "database" then "game".

## Connect to server terminal

If you need to access the terminal on the server you can enter `docker exec -it topaz_game_1 bash` where `topaz_game_1` is the container name from the `docker ps` command. To exit type `exit`.

## Transfer files to server from local machine

If you need to transfer files from your local machine to the server you can use the `docker cp` command. All code on the server exists in the `/topaz` directory. See below for example.
This is useful for things like updating and testing the lua scripts without needing to restart the server.

Example copying godmode.lua script from local machine to server (where server name is `topaz_game_1`):
`docker cp scripts/commands/godmode.lua topaz_game_1:/topaz/scripts/commands/godmode.lua`
