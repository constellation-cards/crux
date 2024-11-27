# crux

A Docker image for compiling Constellation Cards JSON into a printable PDF,
an image montage for use in Tabletop Simulator, and so on.

To invoke the docker image, you need to set the env variable `CRUX_CARDS_JSON` to the path (relative to the container)
where the cards JSON can be found.
For example, if you mount card data at `cards`, you'd set `CRUX_CARDS_JSON` to `/cards/cards.json`.

You can optionally set `CRUX_CARDS_DECK` to the full name of a deck from the cards JSON file, e.g. "CORE".
This will only process cards from that deck.

If you specify `CRUX_CONTEXT_TEMPLATE`, this file will be parsed as an EJS template.
You will receive a "cards" variable containing an array of card records,
and a "description" variable which is a function for parsing card description text.

If you specify `CRUX_CONTEXT_ENV`, this file will be used as an environment file for ConTeXt.

If you don't specify these variable, default templates will be used.

Build artifacts will be copied to the path specified in `CRUX_CARDS_BUILD`.
You should mount a directory at this point to capture the results.
