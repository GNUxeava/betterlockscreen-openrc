# Betterlockscreen
> fast and sweet looking lockscreen for linux systems with effects and OpenRC support!

<div align="center">
  <a href="https://github.com/pavanjadhaw/betterlockscreen/blob/main/LICENSE"><img src="https://img.shields.io/github/license/pavanjadhaw/betterlockscreen.svg?style=for-the-badge"></a>
</div>
<br />

![scrot2](https://github.com/pavanjadhaw/betterlockscreen.demo/raw/master/scrots/scrot2.png 'scrot2.png')
<br />

## Table of Contents

- [About](#about)
- [How it works](#how-it-works)
- [System Requirements](#system-requirements)
- [Installation](#installation)
- [Configuration](#configuration)
- [Usage](#usage)
- [Background](#background)
- [Keybinding](#keybindings)

## About

Most of i3lock wrapper-scripts out there take an image, add some effect(s) then lock with the modified image as locker-background. Overall experience doesn't feel natural given delay of 2-3 seconds.

> Who would like a delay of 2-3 seconds while locking screen?

So Betterlockscreen was my attempt to solve this problem, as we dont need to change lockscreen background frequently this script caches images with effect so overall experience is simple and as fast as native i3lock.

## How it works

The script takes a directory or image, adds various effects and caches the images in special directory. Those cached images will be used as locker-background depending on configuration provided by user.

## System Requirements

* [i3lock-color](https://github.com/Raymo111/i3lock-color) `>= 2.13.c.3`
* [ImageMagick](https://imagemagick.org/)
* xdpyinfo, xrandr, xrdb and xset from [X.Org](https://www.x.org/)
* (Optional) [Dunst](https://dunst-project.org/)
* (Optional) [feh](https://feh.finalrewind.org/) for wallpaper-functionality

> Note: Make sure your system has all dependencies satisfied

## Installation
### Installation Script

Clone the repo and run the script. The script is very simple and takes two parameters:
  * `<install-mode>`: (string) 'user' installs to '~/.local/bin/', 'system' installs to '/usr/local/bin'
  * `[<version>]`: (string) defaults to local, which will install from the local copy of the repo. Use 'latest', which will determine the latest tag from git or specified branch/tag 

For system-installation:
```sh
bash install.sh system
```

For user-installation:
```sh
bash install.sh user
```

### Manual Installation

Clone the repo and copy `betterlockscreen` to the relevant directory. Make sure you have dependenncies installed. See [System Requirements](#system-requirements) above.

## Configuration

You can customize betterlockscreen for your needs, copy the config file from the examples-directory to `~/.config/betterlockscreenrc` and edit it accordingly.

If no configuration-file is found, then the default configurations (which is equal to the example but currently hardcoded) will be used.


## Usage

Run `betterlockscreen` and point it to either a directory (`betterlockscreen -u "path/to/dir"`) or an image (`betterlockscreen -u "/path/to/img.jpg"`) and that's all. `betterlockscreen` will change update its cache with image you provided.

```sh
Usage: betterlockscreen [-u <PATH>] [-l <EFFECT>] [-w <EFFECT>]

  -u --update <PATH>
      Update lock screen image

  -l --lock <EFFECT>
      Lock screen with cached image

  -w --wall <EFFECT>
      Set wallpaper with cached image

Additional arguments:

  --display <N>
      Set display to draw loginbox

  --span
      Scale image to span multiple displays

  --off <N>
      Turn display off after N seconds

  --fx <EFFECT,EFFECT,EFFECT>
      List of effects to apply

  -- <ARGS>
      Pass following arguments to i3lock

Effects arguments:

  --dim <N>
      Dim image N percent (0-100)

  --blur <N>
      Blur image N amount (0.0-1.0)

  --pixel <N,N>
      Pixelate image with N shrink and N grow (unsupported)

  --color <HEX>
      Solid color background with HEX
```


#### Examples
1. Update image cache with random image
`betterlockscreen -u ~/Wallpapers`

2. Update image cache with only dim and pixel effects
`betterlockscreen -u ~/Wallpapers/image.png --fx dim,pixel`

3. Update image cache with random image, multiple monitors, login on 1, spanning
`betterlockscreen -u ~/Wallpapers/Dual/ --display 1 --span`

4. Update image cache with solid background only (ignore errors)
`betterlockscreen -u . --fx color --color 5833ff`

5. Update image cache with different background images
`betterlockscreen -u ~/Wallpapers/image1.png -u ~/Wallpapers/image2.png`

6. Lock screen with blur effect
`betterlockscreen --lock blur`

7. Lock screen with multiple monitors, spanning
`betterlockscreen -l dimblur --display 1 --span`


## Background

Add this line to `.xinitrc`.

```sh
# set desktop background with custom effect
betterlockscreen -w dim

# Alternative (set last used background)
source ~/.fehbg
```

### i3wm

Add this line to `~/.config/i3/config`

```sh
# set desktop background with custom effect
exec --no-startup-id betterlockscreen -w dim

# Alternative (set last used background)
exec --no-startup-id source ~/.fehbg
```

## Keybindings

To lockscreen using keyboard shortcut

### i3wm

Add this line to your `~/.config/i3/config`

```sh
bindsym $mod+shift+x exec betterlockscreen -l dim
```

### bspwm

Add this line to your `~/.config/sxhkd/sxhkdrc`

```sh
# lockscreen
alt + shift + x
    betterlockscreen -l dim
```
---

## Countributing

Please see [CONTRIBUTING.md](CONTRIBUTING.md).

## License

Betterlockscreen is under [MIT](https://github.com/pavanjadhaw/betterlockscreen/blob/main/LICENSE) license.

### Feel free to use and distribute

- Hat tip to anyone who's code was used
- Thanks to those who contributed to make it better
- Inspiration - [r/unixporn](https://www.reddit.com/r/unixporn)
