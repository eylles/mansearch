#!/bin/sh

if [ -n "$FZF_PREVIEW_COLUMNS" ]; then
    export MANWIDTH="$FZF_PREVIEW_COLUMNS"
fi

exec man "$@" 2>/dev/null | col -bx
