# Custom ASCII art MOTD banner for Ubuntu

Replaces default Ubuntu login messages with a custom ASCII art banner.

```
 ___    ___            ___    _               _
(  _`\ (  _`\         (  _`\ ( )_            ( ) _
| (_) )| (_) ) ______ | (_(_)| ,_) _   _    _| |(_)   _
|  _ <'|  _ <'(______)`\__ \ | |  ( ) ( ) /'_` || | /'_`\
| (_) )| (_) )        ( )_) || |_ | (_) |( (_| || |( (_) )
(____/'(____/'        `\____)`\__)`\___/'`\__,_)(_)`\___/'

```


## What it does

- Shows a custom ASCII art logo on login
- Removes unnecessary Ubuntu messages (help links, ESM/pro ads, news)
- Keeps useful info: system load, memory, IP, available updates
- Supports 8 colors

## Usage

```bash
sudo ./install-banner.sh
```

## Changing the color

Open the banner file and change the `COLOR` line:

```bash
nano /etc/update-motd.d/05-banner
```

Available colors:

```bash
COLOR="\e[95m"  # pink
COLOR="\e[93m"  # yellow
COLOR="\e[92m"  # green
COLOR="\e[96m"  # cyan
COLOR="\e[91m"  # red
COLOR="\e[94m"  # blue
COLOR="\e[97m"  # white
COLOR="\e[30m"  # black
```


## Customizing the ASCII art
 
Generate your own logo at [patorjk.com/software/taag](https://patorjk.com/software/taag/).
 
> **Warning:** Avoid wide fonts (e.g. `Big Money-sw`, `Banner3`). Wide ASCII art will wrap and break on smaller terminal windows. Stick to compact fonts like `Small`, `Mini`, or `Doom` to keep the banner readable at any terminal size.
 
After generating, paste the art into `install-banner.sh` between the `BANNER` markers:
 
```bash
nano install-banner.sh
```
 
The `BANNER` markers tell bash where the ASCII art starts and ends. Do not remove them:
 
```bash
cat << 'BANNER'
...paste your ASCII art here...
BANNER
```


## Requirements

- Ubuntu 24.04 LTS
- root access
