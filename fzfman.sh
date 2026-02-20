#!/bin/sh

if [ -n "$FZF_PREVIEW_COLUMNS" ]; then
    export MANWIDTH="$FZF_PREVIEW_COLUMNS"
fi

export MAN_KEEP_FORMATTING=1

exec man "$@" 2>/dev/null
