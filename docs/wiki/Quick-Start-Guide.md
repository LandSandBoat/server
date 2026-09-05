# Main Supported Platforms

**NOTE:** While it's possible to achieve the steps in this guide using different tools and versions of the software we list, we _cannot recommend enough_ following this guide to the letter and make sure you have everything working before you stray from the well-tested path. Using software parts from a pre-made stack like WAMP, the built-in Python that ships with Strawberry Perl, etc. is NOT suitable for the first time you're getting set up. Please follow the instructions to the letter and only start swapping pieces out once you have a working server.

_(click to expand sections)_

-----

<details>
  <summary>Windows 10/11</summary>

## To Install

* Install [Git for Windows](https://gitforwindows.org/).
  * The latest version is fine, accept defaults, change default text editor if desired.
* Install [Visual Studio 2026](https://visualstudio.microsoft.com/vs/community/).
  * **Use 2026.** We like to use the latest compilers we can.
  * **YOU MUST** check the checkbox for `Desktop development with C++` workload (under Desktop & Mobile) or you won't be able to build anything.
* Install [MariaDB Server](https://mariadb.org/download/?t=mariadb&p=mariadb&r=10.11.18&os=windows&cpu=x86_64&pkg=msi&m=xtom_ams).
  * Use the latest in the `10.11.x` family of releases, default settings are mostly OK - aside from:
    * **Set a root password**.
    * **Use UTF8 as character set**.
    * **IT IS INCREDIBLY IMPORTANT** that you check the `Use UTF8 as server's character set` checkbox on the `Default instance properties` page during installation. If you don't do this you may face very hard to diagnose crashes.
* Install [Python 3.14.x](https://www.python.org/downloads/).
  * Use the latest `3.14` release. Our CI builds and tests on `3.14`; older or newer major versions break with our usage.
  * During installation YOU MUST check the `add python.exe to PATH` checkbox.
* Open a PowerShell window and navigate to your chosen install directory.
* To download the latest code, install Python requirements, and copy the configuration files:

```ps
git clone --recursive https://github.com/LandSandBoat/server.git
py -3 -m pip install -r server/tools/requirements.txt
cp server/settings/default/* server/settings
```

* Edit the file `network.lua` inside `server\settings\` and set `SQL_PASSWORD` to the root password you set during MariaDB setup.
  * Leave `SQL_LOGIN` as `'root'` and `SQL_DATABASE` as `'xidb'`.
  * Keep the quotation marks around the password!
* Edit the file `main.lua` inside `server\settings\` with your desired settings for your server.
  * Keep the quotation marks around any value that already has them.
* Back in your PowerShell window, navigate to `server\` and build the database:

```ps
py -3 ./tools/dbtool.py
```

* Follow the on-screen instructions:

```txt
Please enter the path to your MySQL bin directory or press enter to check PATH.
e.g. C:\Program Files\MariaDB 10.11\bin\
```

```txt
Database xidb does not exist.
Would you like to create new database: xidb? [y/N]
```

* You will eventually get to the main `dbtool` menu.

```txt
o------------------------------------------o
|  LandSandBoat Database Management Tool   |
|            Connected to xidb             |
|                  #e222b                  |
o------------------------------------------o
| 1. Update DB                             |
| 2. Check migrations                      |
| 3. Backup                                |
| 4. Restore/Import                        |
| r. Reset DB                              |
| t. Maintenance Tasks                     |
| p. Player Administration                 |
| l. Launch Server                         |
| s. Settings                              |
| q. Quit                                  |
o------------------------------------------o
```

* An extra `e. Express Update` entry appears at the top of the menu when an express update is available for your database version.
* You can exit out of `dbtool` now with `q`.
* Open the `server` root folder in Visual Studio 2026.
  * `Open a local folder` on the splash screen.
  * Make sure VS has administrator priviledges so it can fetch all the data it needs.
* The build will start configuring itself for your system.
  * This stage is done when the `CMake` window at the bottom of the window says `1> CMake generation finished.`.

⚠️ **Check the configuration dropdown near the top of the window before you build.** Visual Studio often selects a `Debug` configuration by default. A `Debug` build of the map server is many times slower than an optimized one. Slow enough that it becomes painful to use. Only build `Debug` when you are chasing a serious problem and need the full debug information.

* Set the dropdown to `Default (RelWithDebInfo)`.
  * This is suitable for daily use.
* In the top toolbar, select `Build > Build All`.
  * This may take a little while!
* You should eventually see `Build All succeeded.`.
  * Congratulations, you've built the server! You can now go onto [Next Steps](#next-steps).

## To Update

* **Take down all of your server processes!**
* Open a PowerShell window and navigate to your `server` directory.
* Stash any changes you've made and pull the latest code from upstream:

```ps
git stash
git pull
git submodule update --init --recursive --progress
git stash pop
```

⚠️ Pay attention! If you stashed any changes, there is a chance you will see the following:

>CONFLICT (content): Merge conflict in _**some file**_

⚠️ If this happens, you need to manually edit the conflicting files before continuing.

* Navigate to `server` and update the database:

```ps
py -3 ./tools/dbtool.py update
```

* Open the `server` root folder in Visual Studio 2026.
  * CMake _may_ reconfigure, wait for it to complete like before.
  * Check the configuration dropdown again. You'll still want to use `Default (RelWithDebInfo)`.
* In the top toolbar, select `Build > Build All`.
  * This may take a little while if you have a weaker machine.
* You should eventually see `Build All succeeded.`.

</details>

-----

<details>
  <summary>Linux (Ubuntu 26.04)</summary>

## To Install

```txt
NOTE: We try to keep up to date with whatever the latest LTS release of Ubuntu is (Ubuntu 26.04). We run all of our CI builds on this release. We can't guarantee that older LTS versions will work. When in doubt: update!
```

* Run these steps to use Mariadb's community provided ("CS" instructions) .deb packages through apt:
  * https://mariadb.com/docs/server/connect/programming-languages/c/install/#CS_Package_Repository
* Use your package manager to install the following packages or their equivalents:

```sh
sudo apt update
sudo apt install git python3 python3-pip g++-15 cmake make pkg-config libluajit-5.1-dev libzmq3-dev libssl-dev zlib1g-dev libzstd-dev libdwarf-dev mariadb-server libmariadb-dev-compat binutils-dev
```

* The project needs a compiler with C++23 support and CMake 3.25 or newer. Our CI builds with `g++-15` and `clang-22`. If your distribution only offers an older `g++`, expect build failures.

* Download the latest code, install Python requirements, and copy the configuration files:

```sh
git clone --recursive https://github.com/LandSandBoat/server.git
pip3 install -r server/tools/requirements.txt
cp server/settings/default/* server/settings
```

* Run the following script to improve database security:

```sh
sudo mysql_secure_installation
```

* Type the following to create a database user with the login <ins>_**xi**_</ins> and password <ins>_**password**_</ins>, and an empty database called <ins>_**xidb**_</ins>. NOTE: You _SHOULD_ change **ALL THREE OF THESE** to improve security:

```sh
sudo mysql -u root -p -e "CREATE USER 'xi'@'localhost' IDENTIFIED BY 'password';CREATE DATABASE xidb CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;USE xidb;GRANT ALL PRIVILEGES ON xidb.* TO 'xi'@'localhost';"
```

* Edit the file `network.lua` inside `server/settings/` and change the `SQL_LOGIN`, `SQL_PASSWORD`, and `SQL_DATABASE` to the login, password, and database you used in the above command (default xi, password, xidb).
  * Make sure to include the quotation marks!
* Edit the file `main.lua` inside `server/settings` with your desired settings for your server.
  * Keep the quotation marks around any value that already has them.
* In the `server` directory, build the executables:

```sh
python3 ./tools/build.py
```

* `build.py` configures and builds with the `default` CMake preset, which is `RelWithDebInfo`. This is the configuration you want for everyday use. Pass `--preset debug` only when you are chasing a serious problem. A `Debug` build of the map server is many times slower.
* If you would rather drive CMake yourself, this is what `build.py` runs:

```sh
cmake --preset default
cmake --build --preset default
```

* Wait for the build to complete, then build the database. Still from the `server` directory:

```sh
python3 ./tools/dbtool.py
```

* Select 'Reset DB' and follow the instructions to "reset" the database.

* Congratulations, you've built and set up the server! You can now go onto [Next Steps](#next-steps).

## To Update

* **Take down all of your server processes!**
* Open the `server` directory in a terminal.
* Stash any changes you've made and pull the latest code from upstream:

```sh
git stash
git pull
git submodule update --init --recursive --progress
git stash pop
```

⚠️ Pay attention! If you stashed any changes, there is a chance you will see the following:

>CONFLICT (content): Merge conflict in _**some file**_

⚠️ If this happens, you need to manually edit the conflicting files before continuing.

* Rebuild the executables:

```sh
python3 ./tools/build.py
```

* Wait for the build to complete, then update the database. Still from the `server` directory:

```sh
python3 ./tools/dbtool.py update
```

</details>

-----

# Experimental Platforms

**NOTE:** These platforms should work, but are not actively maintained or used by the development team. The development team (especially in the case of OSX) might not have the hardware or expertise to be able to help you debug problems on these platforms. Use at your own risk. Good luck!

_(click to expand sections)_

-----

<details>
  <summary>OSX</summary>

## Use Docker first

**On macOS, run the server in Docker rather than building it on bare metal.**

A bare-metal macOS build works, but it is the platform the development team can help you with least. You will be the one debugging any Homebrew, linker, or LuaJIT problem you hit. Docker gives you the same Linux build we test in CI, and keeps FFXI's dependencies out of your system.

We publish images for `linux/amd64`, `linux/arm64`, and `linux/arm/v7`, so Apple Silicon Macs pull a native `arm64` image and run at full speed. No emulation.

Start here:

* [`docker/README.md`](https://github.com/LandSandBoat/server/blob/base/docker/README.md)

## To Install on bare metal

If you would rather build natively, read the warning at the top of this section and continue.

* Get dependencies from brew:

```sh
brew install git pkg-config cmake ninja openssl mariadb zeromq luajit
```

* Build with Apple Clang, which ships with the Xcode command line tools.
* Download and build the server binaries:

```
git clone --recursive https://github.com/LandSandBoat/server.git
cd server
python3 ./tools/build.py
```

* `build.py` uses the `default` CMake preset, which builds `RelWithDebInfo`. Use `--preset debug` only when you need full debug information. A `Debug` map server is many times slower.

From here, the instructions are the same as the Linux builds. Good luck!

In your CMake configuration, you should see this:
```
-- LuaJIT_FOUND: TRUE
-- LuaJIT_LIBRARY: /usr/local/lib/libluajit-5.1.dylib
-- LuaJIT_INCLUDE_DIR: /Users/runner/work/server/server/ext/lua/include
```

If the `LuaJIT_INCLUDE_DIR` is pointing somewhere other than `<SERVER_ROOT>/server/server/ext/lua/include`, you can change it during CMake configuration by using:
```
cmake --preset default -DLuaJIT_INCLUDE_DIR=<SERVER_ROOT>/server/ext/lua/include
```

</details>

-----

<details>
  <summary>Linux (through WSL)</summary>

All of the instructions for Linux should be valid for WSL. There are additional points covered in the [Working with WSL](Working-with-WSL) article.

</details>

-----

<details>
  <summary>Linux (Arch)</summary>

**NOTE**: Nobody has tried this in a long time. It's probably out of date.

Some users have had success building and running on Arch. We can't and won't support Arch as main platform. Good luck!

```sh
sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm git python python-pip gcc cmake make pkgconf luajit zeromq openssl zlib zstd libdwarf mariadb binutils
sudo mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
sudo systemctl enable mariadb
sudo systemctl start mariadb
```

Install the Python requirements. Arch marks its system Python as externally managed, so use a virtual environment:

```sh
python -m venv .venv
source .venv/bin/activate
pip install -r server/tools/requirements.txt
```

Then build as described in the Ubuntu section:

```sh
python3 ./tools/build.py
```

</details>

-----

<details>
  <summary>Linux (Raspberry Pi)</summary>

**NOTE**: Nobody has tried this in a long time. It's probably out of date.

Build instructions should be the same or similar as a regular Linux build. The build process may take a long time, but running the game doesn't take much computing power.

#### Power

Raspberry Pis require at least a 2.5amp power supply to run at full power. If you are getting a little yellow lightning bolt in the top right of your display you have hit the limit of your current power supply. If this happens you may not be able to take full advantage of your CPU's power and may lose connectivity to Bluetooth or USB devices.

Should you hit either of these 2 limitations it will take considerably longer for the build process to finish, if it finishes at all!

#### LuaJIT

Depending on your distro, the LuaJIT that comes through the package manager may not have required fixes for ARM platforms included with it. If you hit LuaJIT problems, build and install it from source:

```sh
git clone https://github.com/LuaJIT/LuaJIT.git
cd LuaJIT
sudo make install -j $(nproc)
```

`make install` creates the `luajit` symlink for you. Check it with `ls -l /usr/local/bin/luajit` and create it yourself if it is missing, using the versioned name the installer reported.

#### RAM

Each server process startup can be quite resource intensive for both CPU and RAM. Older Raspberry Pis don't have much RAM, so you may need to start up each of the server processes one-by-one to ensure that they start and run correctly.

</details>

-----

<details>
  <summary>Linux (Gentoo OpenRC)</summary>

**NOTE**: Nobody has tried this in a long time. It's probably out of date.
  
Ensure your system is up to date:
```sh
sudo emerge --sync && emerge -avuDU @world
```
Emerge the following packages and their dependencies: 
```sh
sudo emerge -a dev-db/mariadb dev-lang/luajit dev-vcs/git net-libs/zeromq
```
Clone the repo in your folder of choice, then copy the settings files:
```sh
cd ~/ && mkdir git && cd ~/git 
git clone --recursive https://github.com/LandSandBoat/server.git
cp server/settings/default/* server/settings
```
MariaDB will need to be configured and the database initialized before the service can be started. If you have issues, or are using Systemd instead of OpenRC, refer to the [Gentoo Wiki](https://wiki.gentoo.org/wiki/MariaDB).
```sh
sudo emerge --config dev-db/mariadb
sudo rc-update add mysql default
sudo rc-service mysql start
```
In order to use dbtool for managing your database, additional packages are required, one of which is not in the main Gentoo repository. This is a problem on Gentoo as installing with pip instead of portage can break your system. Thankfully, with an overlay we can get what we need (ensure you have already installed and configured [eselect-repository](https://wiki.gentoo.org/wiki/Eselect/Repository)):
```sh
sudo eselect repository add claytabase git https://github.com/claybie/claytabase.git
sudo emaint sync -r claytabase
```
Now we can emerge all the necessary packages for dbtool:
```sh
sudo emerge -a dev-python/black dev-python/colorama dev-python/GitPython dev-python/mariadb dev-python/pylint dev-python/pyyaml dev-python/pyzmq dev-python/regex
```

⚠️ **This list is incomplete.** `server/tools/requirements.txt` is the source of truth, and it has grown since this section was written. At the time of writing it also needs `ruamel.yaml`, `requests`, `bcrypt`, `jinja2`, and `jsonschema`. Without them `dbtool` fails on import.

Check `requirements.txt` yourself and emerge the matching `dev-python/*` atoms. Portage atom names do not always match the PyPI name, so search with `emerge -s` if an obvious guess fails.
Additionally, you will also need to emerge the below packages if you wish to use [pydarkstar](https://github.com/AdamGagorik/pydarkstar) as an automated auction house:
```sh
sudo emerge -a dev-python/beautifulsoup4 dev-python/sqlalchemy
```
The process for securing the MariaDB installation, creating the SQL database, building the project, populating the database using dbtool and performing future updates is the same as on Ubuntu. See the *Linux (Ubuntu 26.04)* section above.
</details>

-----

<details>
  <summary>Docker</summary>

We maintain Dockerfiles in the server repo under `docker/`, and our CI builds them, runs `xi_test` and startup checks inside the container, and publishes images to `ghcr.io/landsandboat/server` for `linux/amd64`, `linux/arm64`, and `linux/arm/v7`.

* [`docker/README.md`](https://github.com/LandSandBoat/server/blob/base/docker/README.md)

</details>

-----

# Next Steps

## Starting the server

The server is four separate processes. You can start them with `dbtool`, or by hand.

**With dbtool (easiest):**

1. Run `dbtool` from `server/`:

```sh
python3 ./tools/dbtool.py
```

Windows: `py -3 ./tools/dbtool.py`

2. Choose `l. Launch Server`. This starts `xi_connect`, `xi_search` and `xi_world`, then starts one `xi_map` for each distinct zone port you have configured (default 1).

**By hand:**

Launch the newly-built `xi_*` executables from your repo root:

* `xi_connect`
* `xi_world`
* `xi_search`
* `xi_map`

On Windows these have an `.exe` extension. Each one opens its own console window; leave them all running. Start `xi_map` last, after the other three are up.

_If a process doesn't run, or closes immediately, check the log output in the `log/` or `dmp/` folders for clues._

-----

* Once everything is launched, you should connect to your server as soon as possible and make sure everything is running as expected.
  * You should make sure you have a working client for local testing: [Client Setup Guide (Windows)](Client-Setup-Windows) (This includes sections for setting up Ashita and Windower, and getting the _latest_ version of `xiloader`)

-----

* Once you've confirmed everything is working and you can connect to your local server, you can start exploring the [Post-Install Guide](Post-Install-Guide) and articles in the Development section. These articles tell you how to do important things such as:
  * Changing settings
  * Making a Game Master/Admin character and finding/using GM commands (giving yourself items, teleporting, etc.)
  * Making your server available to your friends and the wider internet
  * Further guides, including; deeper customisation using modules, performance profiling and preparing for large userbases, etc.
  * And many other useful things!
