#!/bin/sh

myname="${0##*/}"

spaths=""
mpaths=$(manpath | awk '{gsub(/:/," "); print}')

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

selection=$(find $spaths ! -name '*.dist' -type f 2>/dev/null | \
    awk '
        {
          gsub(/.gz/,"");
          gsub(/.*man[0-9]\//,"");
          print
        }
        ' | \
    fzf  \
    --cycle \
    --prompt='filter: ' \
    --height 100% \
    --preview-window 70% \
    --bind alt-k:preview-up \
    --bind alt-j:preview-down \
    --bind='pgdn:half-page-down,pgup:half-page-up' \
    --preview "@placeholder@/fzfman {1}" \
)

if [ -n "$selection" ]; then
    man "$selection"
else
    printf '[%s] %s:\n' "$myname" "no option chosen"
fi
