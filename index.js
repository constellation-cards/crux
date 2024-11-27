const ejs = require("ejs");
const fs = require("fs");
const ramda = require("ramda");

const { concat, isEmpty, isNil, pick, reduce, repeat } = ramda;

// Turn an array of records into a map of UID => [Record, Record...]
function recordsToMap(records) {
  return reduce((a, v) => {
    a[v.uid] = v;
    return a;
  }, {}, records);
}

if (isNil(process.env.CRUX_CARDS_JSON) || isEmpty(process.env.CRUX_CARDS_JSON)) {
  throw new Error("Environment variable CRUX_CARDS_JSON cannot be empty");
}

if (isNil(process.env.CRUX_CONTEXT_TEMPLATE) || isEmpty(process.env.CRUX_CONTEXT_TEMPLATE)) {
  throw new Error("Environment variable CRUX_CONTEXT_TEMPLATE cannot be empty");
}

const cardDataRaw = fs.readFileSync(process.env.CRUX_CARDS_JSON).toString();
const cardData = JSON.parse(cardDataRaw);

const decks = recordsToMap(cardData.decks);
const stacks = recordsToMap(cardData.stacks);

// Dereference decks and stacks and bake them into our structure
const cards = reduce(
  (cards, card) => {
    // Uncomment to duplicate cards based on quantity
    // We want this if we're printing cards, but not for TTS
    const quantity = 1; // newCard.quantity
    const newCard = {
      ...card,
      deck: pick(["uid", "name"], decks[card.deck]),
      stack: pick(["uid", "name", "icons"], stacks[card.stack]),
    };
    return concat(cards, repeat(newCard, quantity));
  },
  [],
  cardData.cards
);

const description = (inputString) => {
  const lines = inputString.split("\n").map(line => {
    if(line.startsWith("//")) {
      return `\\constellationquote{${line.substr(2)}}`;
    } else {
      return line;
    }
  });
  return lines.join("\n\n");
}

const template = fs.readFileSync(process.env.CRUX_CONTEXT_TEMPLATE).toString();
const output = ejs.render(template, {cards, description});

console.log(output);
