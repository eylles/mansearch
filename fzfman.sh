#!/bin/sh

if [ -z "$FZF_PREVIEW_COLUMNS" ]; then
    FZF_PREVIEW_COLUMNS="$(tput cols)"
fi

MANWIDTH="$(( FZF_PREVIEW_COLUMNS - 1 ))"
export MANWIDTH

if [ -z "$MAN_BIN" ]; then
    MAN_BIN=/usr/bin/man
fi

if [ -z "$PREVIEW_PAGER" ]; then
    PREVIEW_PAGER=/bin/cat
fi

export MAN_KEEP_FORMATTING=1
export MANPAGER="$PREVIEW_PAGER"

exec $MAN_BIN "$@" 2>/dev/null
