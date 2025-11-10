# Docker

## Meshes

`losmeshes` and `navmeshes` are included in a separate image. You can load these into a volume with the following command:

```sh
docker run --rm -v losmeshes:/losmeshes -v navmeshes:/navmeshes ghcr.io/landsandboat/ximeshes:latest
```
Once the volumes are created, you can delete the image.

## Database

**A DATABASE IS NOT INCLUDED WITH THIS IMAGE!** Database connection credentials are required to run the executables, you can set these through environment variables:

```
XI_NETWORK_SQL_HOST
XI_NETWORK_SQL_PORT
XI_NETWORK_SQL_DATABASE or MARIADB_DATABASE
XI_NETWORK_SQL_LOGIN or MARIADB_USER
XI_NETWORK_SQL_PASSWORD or MARIADB_PASSWORD
```

## Running the container

### Default user

The image is built with a default user and group named xiadmin with UID and GID 1000.

### Configuration

#### Database migrations

You should run a dbtool update inside the container before starting the executables.

To increase the efficiency and avoid a full import every time the container is recreated, you should create and mount `config.yaml` to `/server/tools/config.yaml`.

#### Port binding

The server executables running within the container will listen on ports 54001, 54002, 54230, and 54231 (and 8088 if you enable the HTTP API).

### Starting using a minimal configuration

```sh
docker run --name some-lsb-server \
-e XI_NETWORK_SQL_HOST=host.docker.internal \
-e XI_NETWORK_SQL_PORT=3306 \
-e XI_NETWORK_SQL_DATABASE=xidb \
-e XI_NETWORK_SQL_LOGIN=root \
-e XI_NETWORK_SQL_PASSWORD='root' \
-p 54001:54001 \
-p 54002:54002 \
-p 54230:54230 \
-p 54231:54231 \
-v losmeshes:/server/losmeshes \
-v navmeshes:/server/navmeshes \
ghcr.io/landsandboat/server:latest
```

### Customization

#### Environment variables

You can use environment variables to adjust individual settings in the following format:

```
-e XI_{file}_{setting}=value
```

#### Settings files

Mount settings for more extensive changes.

```
--mount type=bind,src="$(pwd)"/settings/map.lua,dst=/server/settings/map.lua
```

#### Modules

Mount Lua and SQL runtime modules for further customization.

```
--mount type=bind,src="$(pwd)"/modules,dst=/server/modules
```

- You must [build the image](#building-the-image) to use C++ modules.

## ...via Docker Compose

Example `docker-compose.yml`:

```yaml
x-dbcreds: &dbcreds
  # MARIADB_ROOT_PASSWORD required if setting up fresh database.
  # Or generate a random root password and print it to build log:
  # MARIADB_RANDOM_ROOT_PASSWORD: true
  MARIADB_DATABASE: xidb
  MARIADB_USER: xiadmin
  MARIADB_PASSWORD: 'password'

x-common: &common
  image: ghcr.io/landsandboat/server:latest
  environment:
    <<: *dbcreds
    XI_NETWORK_HTTP_HOST: 0.0.0.0
    XI_NETWORK_ZMQ_IP: world
    XI_NETWORK_SQL_HOST: database
    # XI_{file}_{setting}: value
  volumes:
    - losmeshes:/server/losmeshes
    - navmeshes:/server/navmeshes
    - ./config.yaml:/server/tools/config.yaml
    # - ./map.lua:/server/settings/map.lua
    # - ./modules:/server/modules

services:
  database:
    image: mariadb:lts
    restart: always
    command: ['--character-set-server=utf8mb4', '--collation-server=utf8mb4_general_ci']
    environment:
      <<: *dbcreds
    volumes:
      - database:/var/lib/mysql
    healthcheck:
      test: ["CMD", "healthcheck.sh", "--connect", "--innodb_initialized"]
      start_period: 10s
      interval: 10s
      timeout: 5s
      retries: 3

  database-update:
    <<: *common
    command: ["python", "/server/tools/dbtool.py", "update"]
    depends_on:
      database:
        condition: service_healthy

  connect:
    <<: *common
    command: ["/server/xi_connect"]
    restart: unless-stopped
    ports:
      - "54001:54001"
      - "54230:54230"
      - "54231:54231"
    depends_on:
      database:
        condition: service_healthy
        restart: true
      database-update:
        condition: service_completed_successfully

  search:
    <<: *common
    command: ["/server/xi_search"]
    restart: unless-stopped
    ports:
      - "54002:54002"
    depends_on:
      database:
        condition: service_healthy
        restart: true
      database-update:
        condition: service_completed_successfully

  world:
    <<: *common
    command: ["/server/xi_world"]
    restart: unless-stopped
    ports:
      - "8088:8088"
    depends_on:
      database:
        condition: service_healthy
        restart: true
      database-update:
        condition: service_completed_successfully

  map:
    <<: *common
    command: ["/server/xi_map"]
    restart: unless-stopped
    ports:
      - "54230:54230/udp"
    depends_on:
      database:
        condition: service_healthy
        restart: true
      database-update:
        condition: service_completed_successfully
      world:
        condition: service_started

volumes:
  database:
  losmeshes:
    external: true
  navmeshes:
    external: true
```

## Building the image

```sh
docker build -f docker/ubuntu.Dockerfile .
```

The Dockerfiles also support a few build args:

```
UNAME=xiadmin
UGROUP=xiadmin
UID=1000
GID=1000
COMPILER=gcc
CMAKE_BUILD_TYPE=Release
TRACY_ENABLE=OFF
ENABLE_CLANG_TIDY=OFF
PCH_ENABLE=ON
WARNINGS_AS_ERRORS=TRUE
REPO_URL
BRANCH
```

`REPO_URL` and `BRANCH` are required for dbtool unless you mount the host .git directory at runtime.

## Devtools

The `devtools` image contains build and CI tools, but no built executables or server source files. This can be useful for testing or as the base for experimental containers.

## Local CI/Testing

The [dev.docker-compose.yml](../dev.docker-compose.yml) file contains a template for running the CI tests locally. This file should be copied into an untracked file if edits are needed. Don't forget to run the `build` (or `clang_tidy`) and `setup_database` services before running the `test` or `startup_checks` services if they need to be created/updated.

By default there is no database volume, so the database used is ephemeral and is tied to the `database` service container.

## Alpine

Alpine based images are available for both the server and devtools. These are significantly smaller and should work well in most situations, but be aware that they use some different libraries and dependency versions and should be considered experimental.
