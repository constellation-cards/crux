#!/bin/sh

docker run \
  -v $HOME/src/constellation-cards/cards:/cards \
  -v $PWD/out:/out \
  -e CRUX_CARDS_JSON=/cards/cards.json \
  -e CRUX_CARDS_BUILD=/out \
  crux:latest
