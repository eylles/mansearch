#!/bin/sh

myname="${0##*/}"

MANPATH=""
spaths=""
mpaths=$(manpath | awk '{gsub(/:/," "); print}')
use_man_path="$(manpath)"
export MANPATH="$use_man_path"

for mp in $mpaths; do
    spaths="${spaths}${mp}/man1 "
    spaths="${spaths}${mp}/man2 "
    spaths="${spaths}${mp}/man3 "
    spaths="${spaths}${mp}/man4 "
    spaths="${spaths}${mp}/man5 "
    spaths="${spaths}${mp}/man6 "
    spaths="${spaths}${mp}/man7 "
    spaths="${spaths}${mp}/man8 "
    spaths="${spaths}${mp}/man9 "
done

# printf '[%s] %s:\n' "$myname" "man paths"

# for p in $spaths; do
#     printf '\t%s\n' "$p"
# done

#############
# conf vars #
#############

# configurable fzf binary
FZF_BIN=/usr/bin/fzf

# colorscheme for fzf, by default we ship dracula
FZF_COLORS="--color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9,fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 \
--color=preview-bg:#44475a \
--color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6,marker:#ff79c6,spinner:#ffb86c,header:#6272a4"

#config file
CONFIG_DIR="${XDG_CONFIG_HOME:-${HOME}/.config}/$myname"
CONFIG="$CONFIG_DIR/configrc"
if [ -f "$CONFIG" ]; then
    # load config
    . "$CONFIG"
else
    notify-send "${myname}: Error!" "${CONFIG} doesn't exist, example config will be copied"
    if [ ! -d "$CONFIG_DIR" ]; then
        mkdir -p "$CONFIG_DIR"
    fi
    cp @examples-placeholder@/configrc "$CONFIG_DIR/"
    # load config
    . "$CONFIG"
fi

export FZF_DEFAULT_OPTS="${FZF_COLORS}"

selection=$(find $spaths ! -name '*.dist' -type f 2>/dev/null | \
    awk '
        {
          gsub(/.gz/,"");
          gsub(/.*man[0-9]\//,"");
          print
        }
        ' | \
    $FZF_BIN  \
    --cycle \
    --layout=reverse  \
    --prompt='filter: ' \
    --height 100% \
    --header 'Man Search' \
    --preview-window 70% \
    --bind='ctrl-k:up,ctrl-j:down' \
    --bind='alt-k:preview-up,alt-j:preview-down' \
    --bind 'ctrl-d:half-page-down' \
    --bind 'ctrl-u:half-page-up' \
    --bind 'alt-d:preview-half-page-down' \
    --bind 'alt-u:preview-half-page-up' \
    --bind='pgdn:half-page-down,pgup:half-page-up' \
    --preview "@placeholder@/fzfman {1}" \
)

if [ -n "$selection" ]; then
    man "$selection"
else
    printf '[%s] %s:\n' "$myname" "no option chosen"
fi
