#!/bin/bash

set -xeuo pipefail

[ -d "$CRUX_CARDS_BUILD" ] || exit 1

CONTEXT_WORKDIR=${CONTEXT_WORKDIR:-./ctx}

mkdir -p $CONTEXT_WORKDIR

cp ${CRUX_CONTEXT_TEMPLATE:-default.tex.ejs} cards.tex.ejs
cp ${CRUX_CONTEXT_ENV:-env_cards.tex} $CONTEXT_WORKDIR

node index.js > $CONTEXT_WORKDIR/cards.tex

pushd $CONTEXT_WORKDIR
context cards.tex --purgeall

cp cards.pdf $CRUX_CARDS_BUILD/

# TODO: run ImageMagick commands
# TODO: copy image files to $CRUX_CARDS_BUILD
