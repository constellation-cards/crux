# crux

A Docker image for compiling Constellation Cards JSON into a printable PDF,
an image montage for use in Tabletop Simulator, and so on.

To invoke the docker image, you need to set the env variable `CRUX_CARDS_JSON` to the path (relative to the container)
where the cards JSON can be found.
For example, if you mount card data at `cards`, you'd set `CRUX_CARDS_JSON` to `/cards/cards.json`.

You can optionally set `CRUX_CARDS_DECK` to the full name of a deck from the cards JSON file, e.g. "CORE".
This will only process cards from that deck.

Build artifacts will be copied to the path specified in `CRUX_CARDS_BUILD`.
You should mount a directory at this point to capture the results.
