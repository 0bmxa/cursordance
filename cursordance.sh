#!/bin/zsh

SAVE_CURSOR='\e7'
RESTORE_CURSOR='\e8'

function saveCursor    { echo -n "${SAVE_CURSOR}" }
function restoreCursor { echo -n "${RESTORE_CURSOR}" }

function moveCursorUp {
    local lines=$1
    echo -n "\e[${lines}A"
}

function moveCursorDown {
    local lines=$1
    echo -n "\e[${lines}B"
}

function moveCursorRight {
    local lines=$1
    echo -n "\e[${lines}C"
}

function moveCursorLeft {
    local lines=$1
    echo -n "\e[${lines}D"
}

function moveCursorTo {
    local x=$1 y=$2
    # echo -n "\e[${y};${x}H"
    echo -n "\e[${y};${x}f"
}

function centerCursor {
    let midX=${COLUMNS}/2
    let midY=${LINES}/2
    moveCursorTo $midX $midY
}

function whiteBlock {
    local BG_WHITE='\e[48;5;231m'
    local RESET='\e[0m'
    printf "${BG_WHITE} ${RESET}"
}

saveCursor
centerCursor

while true; do
    let direction=${RANDOM}%4
    case "$direction" in
    0)
        moveCursorUp $(( ${RANDOM} % 2 + 1 ))
        whiteBlock
        moveCursorLeft 1
        ;;
    1)
        moveCursorDown $(( ${RANDOM} % 2 + 1 ))
        whiteBlock
        moveCursorLeft 1
        ;;
    2)
        moveCursorRight $(( ${RANDOM} % 2 ))
        whiteBlock
        ;;
    3)
        moveCursorLeft $(( ${RANDOM} % 2 + 2 ))
        whiteBlock;
        ;;
    esac
    sleep .02
done

restoreCursor