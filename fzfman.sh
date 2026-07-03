#!/bin/sh

if [ -n "$FZF_PREVIEW_COLUMNS" ]; then
    export MANWIDTH="$FZF_PREVIEW_COLUMNS"
fi

if [ -z "$MAN_BIN" ]; then
    MAN_BIN=/usr/bin/man
fi

export MAN_KEEP_FORMATTING=1
export MANPAGER=/usr/bin/cat

exec $MAN_BIN "$@" 2>/dev/null
