#!/bin/sh

if [ -n "$FZF_PREVIEW_COLUMNS" ]; then
    export MANWIDTH="$FZF_PREVIEW_COLUMNS"
fi

man_bin="/usr/bin/man"

export MAN_KEEP_FORMATTING=1
export MANPAGER=/usr/bin/cat

exec $man_bin "$@" 2>/dev/null
