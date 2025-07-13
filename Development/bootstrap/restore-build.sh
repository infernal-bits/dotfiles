#!/usr/bin/env bash

check_command() {
    emulate -L zsh
    local -i comonly gatoo
    comonly=0
    gatoo=0

    if [[ $1 == '-c' ]] ; then
        comonly=1
        shift 1
    elif [[ $1 == '-g' ]] ; then
        gatoo=1
        shift 1
    fi
    if (( ${#argv} != 1 )) ; then
        printf 'usage: ckcom [-c|-g] <command>\n' >&2
        return 1
    fi
    if (( comonly > 0 )) ; then
        (( ${+commands[$1]}  )) && return 0
        return 1
    fi
    if     (( ${+commands[$1]}    )) \
        || (( ${+functions[$1]}   )) \
        || (( ${+aliases[$1]}     )) \
        || (( ${+reswords[(r)$1]} )) ; then
        return 0
    fi
    if (( gatoo > 0 )) && (( ${+galiases[$1]} )) ; then
        return 0
    fi
    return 1
}

typset -aG INSTALLS

if ! check_command git; then
    INSTALLS+=( "git" )
fi
if ! check_command fd; then
    INSTALLS+=( "fd" )
fi