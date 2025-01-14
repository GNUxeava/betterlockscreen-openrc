#!/usr/bin/env bash

cmd_exists () {
    command -v "$1" >/dev/null
}

echof() {
    local colorReset="\033[0m"
    local prefix="$1"
    local message="$2"

    case "$prefix" in
        header) msgpfx="[\e[1;95mB\e[m]" color="";;
        info) msgpfx="[\e[1;97m=\e[m]" color="\033[0;34m";;
        act) msgpfx="[\e[1;92m*\e[m]" color="";;
        ok) msgpfx="[\e[1;93m+\e[m]" color="\033[0;32m";;
        error) msgpfx="[\e[1;91m!\e[m]" color="\033[0;31m";;
        *) msgpfx="" color="";;
    esac
    echo -e "$msgpfx $color $message $colorReset"
}

case $1 in
	system)
		BL_INSTALL_DIR="/usr/local/bin"
	;;

	user)
		BL_INSTALL_DIR="$HOME/.local/bin"

		if [[ ! -d $BL_INSTALL_DIR ]]; then
			mkdir -p "$BL_INSTALL_DIR"
		fi
	;;

	*)
		echo "Usage: $0 <install-mode> [<version>]"
		echo "  <install-mode>: (string) 'user' installs to '~/.local/bin/', 'system' installs to '/usr/local/bin'"
		echo "  <version>: (string) defaults to local, which will install from the local copy of the repo. Use 'latest', which will discard any change made locally and update the repo"
		echo -e "\nPlease note: The order of the parameters *is* relevant."
		exit 1
	;;
esac

echof header "Betterlockscreen-Setup"

if [[ ! -w $BL_INSTALL_DIR ]]; then
	echof error "Unable to write to '$BL_INSTALL_DIR'!"
	exit 1
fi

echof info "Checking system-requirements..."

declare -A DEPS
DEPS["ImageMagick"]="convert"
DEPS["i3lock-color"]="i3lock-color"
DEPS["xdpyinfo"]="xdpyinfo"
DEPS["xrdb"]="xrdb"
DEPS["xset"]="xset"

if ! cmd_exists DEPS["i3lock-color"] && cmd_exists "i3lock"; then
	DEPS["i3lock-color"]="i3lock"
fi

for key in "${!DEPS[@]}"; do
	[[ ! -e "$(command -v ${DEPS[$key]})" ]] && echof error "Missing '$key' under binary named '${DEPS[$key]}'!" && exit 1
done

echof ok "done!"

VERSION=$2
if [[ $VERSION == "latest" ]]; then
	echof info "Updating the repo"
  git restore .
  git clone --no-rebase
	echof ok "done! ($VERSION)"
fi
echof info "Installing Betterlockscreen to '$BL_INSTALL_DIR'... "
cp betterlockscreen "$BL_INSTALL_DIR"
echof ok "done!"

if [[ $PATH != *"$BL_INSTALL_DIR"*  ]]; then
	echof error "Please ensure to add 'export PATH=\"\$PATH:/home/\$USER/.local/bin\"' to your shell-config!\033[0m"
fi

echof ok "Install completed successfully!"
exit 0
