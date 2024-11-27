#!/bin/sh

export CRUX_CARDS_JSON=$HOME/src/constellation-cards/cards/cards.json
export CRUX_CARDS_DECK=CORE
export CRUX_CONTEXT_TEMPLATE=cards.tex.ejs

node index.js > cards.tex

# context cards.txt --purgeall

# TODO: run ImageMagick commands
