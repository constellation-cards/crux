#!/bin/sh

export CRUX_CARDS_JSON=$HOME/src/constellation-cards/cards/cards.json
export CRUX_CARDS_DECK=CORE
export CRUX_CARDS_BUILD=$PWD/out

mkdir $CRUX_CARDS_BUILD

./build.sh
