#!/bin/bash

set -xeuo pipefail

[ -d "$CRUX_CARDS_BUILD" ] || exit 1

CONTEXT_WORKDIR=${CONTEXT_WORKDIR:-./ctx}

[ -d "$CONTEXT_WORKDIR" ] || mkdir -p $CONTEXT_WORKDIR

cp ${CRUX_CONTEXT_TEMPLATE:-default.tex.ejs} cards.tex.ejs
cp ${CRUX_CONTEXT_ENV:-env_cards.tex} $CONTEXT_WORKDIR

node index.js > $CONTEXT_WORKDIR/cards.tex

pushd $CONTEXT_WORKDIR
context cards.tex --purgeall

# [ -d "/tmp" ] || mkdir -m 777 /tmp

# mkdir card-images card-images-back card-images-front
# magick -density 300 cards.pdf -background white -alpha remove -alpha off card-images/cards-%03d.png
# cp card-images/cards-*[24680].png card-images-back/
# cp card-images/cards-*[13579].png card-images-front/

# parallel -N50 montage -geometry +0+0 -tile 10x {} montage-back-{#}.png ::: card-images-back/*
# parallel -N50 montage -geometry +0+0 -tile 10x {} montage-front-{#}.png ::: card-images-front/*

cp cards.pdf $CRUX_CARDS_BUILD/
# cp montage-*.png $CRUX_CARDS_BUILD/

# TODO: rename card image files based on the card UID
# TODO: copy individual card images
