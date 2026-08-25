## WARNING: THIS COSTS MONEY!!!

### There is a generous free tier and free trial credits are available, but once those run out your payment card will start being charged. Be very careful about how you use cloud service providers!

#### Read about the free tier and credits here

- https://cloud.google.com/free
- https://cloud.google.com/free/docs/free-cloud-features

#### BEFORE YOU START

It's perfectly possible for you to build and run the software from your home computer, and host a server for you and your friends that way. It isn't required for you to jump through

#### Prerequisites

You should have **AT LEAST** a passing knowledge of how to get around and do things on a remote Linux machine. If you know what the following terms are and how to use them, you'll probably be OK:

```txt
sudo
cd
ls
ls -l
cat
sh
cp
rm
ssh
scp
git
git clone
nano (and how to save and exit from it)
time
top
htop
screen
screen -ls
screen -r
killall
which
whereis
```

#### Note

- There are many ways to achieve the steps in this guide. These are the most user-friendly steps. Stray from them at your own risk or cost!
- Menu names and items, and costs are all correct as of time of writing: Feb 2023.
- You'll need to make a GCP account. You may or may not need to enter payment card information up front.
- Keep an eye out for discounts or free credits.
- Always keep a close eye on the [Billing Summary](https://console.cloud.google.com/billing) page to make sure you're only spending what you want to.

#### VM Setup

- Create a new project. For this example, we're creating `demo-xi-project`
  - This acts like a folder to keep all of your resources in, and keeps billing for these seperate from other projects.
- It will take a moment to generate the project, you should get redirected to the project dashboard when it's ready.
- Now that you're here, you can start requisitioning resources for your server.
- Go to `Compute Engine`
- `Enable` Compute Engine.
  - This may take a moment. This doesn't cost anything yet.
- You'll eventually be taken to a page that says `VM instances`
- You want to create a new instance with `Create Instance`
- You'll be faced with a page with many many options, and a monthly cost estimate to the side.
- For your first server (until you start to notice frequent performance drops, or 100 concurrent players, whichever comes first), you'll want:

```txt
Machine family: General-Purpose
Series: E2
Machine type: e2-standard-2 (2vCPU, 8 GM memory)
GPUs: Not needed
Display device: Not needed
Boot disk: The default 10 GB storage is fine
Operating system: Change it to `Ubuntu 24.04 LTS`
Boot disk type: Balanced persistent disk
Firewall: Allow both HTTP and HTTPS traffic
```

```txt
Monthly estimate
Total
US$49.92
```

- Click `Create`
  - **YOU ARE NOW BEING CHARGED REAL LIFE MONEY!**
- You'll be taken back to the `VM instances` page, and your new instance will now be listed.
  - **AS LONG AS YOUR INSTANCE IS RUNNING, YOU WILL BE CHARGED REAL LIFE MONEY, REMEMBER TO STOP (NOT DELETE) IT WHEN YOU AREN'T USING IT!**
- The instance is created running, but you don't need it immediately, so you can open the `Three-dots menu` to the right hand side and `Stop` the instance.

### Allowing FFXI Traffic

- Find your way to `Firewall` settings.
  - You can either click on the box that says `Set up firewall rules` or navigate to `VPC network > Firewall`
- `Create a firewall rule`
- Call it `allow-ffxi`, or similar.

```txt
Targets: Specified target tags
Target tags: allow-ffxi
Source filer: IPv4 ranges
Source IPv4 ranges: 0.0.0.0/0
Second source filter: None
Specific protocols and ports:
TCP: 54230,54231,54001,54002
UDP: 54230
```

- Return to `VM instances`
- Click on the name of your instance to go to the summary page for it.
- Click `Edit`
- Scroll down to `Network interfaces`
- You can now add your `allow-ffxi` network tag.
- Click `Save`

### Reserving a Static IP

- Also while the VM is inactive.
- Go to `VPM network > IP addresses`
- Click `Reserve External Static Address`

```txt
Name: ffxi-public-ip (or similar)
Network Service Tier: Standard
IP version: IPv4
Type: Regional
Region: Whatever region you selected for your VM
Attached to: Your instance
```

- Click `Reserve`
  - **YOU ARE NOW BEING CHARGED REAL LIFE MONEY!**
  - A single static public IP should cost about $3 a month.
- This IP is what you can hand out to players trying to connect to your server. If you later want to buy a domain, it should forward to this IP.

### Accessing your VM

- You can now go back to `VM instances`, open the `Three-dots menu`, and hit `Start/Resume` on your instance.
  - **YOU ARE NOW BEING CHARGED REAL LIFE MONEY!**
- Once it's up and running again, you can click the `SSH` button.
- A window will pop up, and you'll have a Linux terminal into your new VM.

### Setting up your LSB Server

- Follow the Linux section of the [Quick Start Guide](Quick-Start-Guide).
- Since this is not a particularly powerful machine, the build/make step might take a while.
  - If it looks like it's stalled on the Linking stage, hold tight, it's a long step.
  - Don't close your original SSH window!
  - You can open a second SSH window and use `htop` to confirm that your machine is busy working, not stalled.
- Build time:

```txt
[100%] Linking CXX executable ../../../xi_map
[100%] Built target xi_map

real    18m23.562s
user    29m31.597s
sys     3m1.356s
```

- You need to set your zone ports to reflect your public IP.
- Launch `python3 tools/dbtool.py`
- `t. Maintenance Tasks`
- `2. Set zone IP addresses`

```txt
Make server public-facing? [y/N] y
Detected your public-facing IP as: 35.209.88.74
Is this correct? [y/N] y
Executing query:

    UPDATE zone_settings SET zoneip = '35.209.88.74'; 
```

- It should automatically (and correctly) detect your public IP. If not, enter it yourself.

### Running your LSB Server (to test)

- Launch your server processes

```sh
screen -d -m -S xi_connect ./xi_connect
screen -d -m -S xi_map ./xi_map
screen -d -m -S xi_world ./xi_world
screen -d -m -S xi_search ./xi_search
```

- Using `screen` will allow your processes to continue when you close your `SSH` window, but they won't survive a VM restart, or come back up after a crash of any kind.
- Connect to your server using `xiloader` or similar, specifying your public IP.
  - `xiloader.exe --server <public IP>`
- You should be able to create a character, log in, and see the intro cutscene.
  - Remember to make your character a GM!

### Running your LSB Server (for real)

- REMEMBER: Take frequent backups using `dbtool`, and backup those backup files somewhere that isn't your VM.
- REMEMBER: If you're just playing with your friends, remember to turn off the server when you're not using it.
- REMEMBER: Be careful about what ports and services you expose to the public!
- REMEMBER: Keep an eye on your usage and billing statements!

- TODO: Instructions to set up all executables as `systemd` services that auto-start on boot, and auto-restart on crash.
  - This should be pretty easily Google-able though.

### Saving Money

- TODO: Tips for how to keep costs down
  - Sustained-use discounts
  - Committed-use discounts
  - Downgrading your machine after building
