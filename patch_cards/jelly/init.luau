--!strict
-- The patch card Jelly (56, ジェリー in the Japanese games), 13 MB.

local cards = require("../rules/patch_cards/cards")

local card: PatchCard = {
    mb = 13,
    effects = {
        cards.hp(120),
        cards.body(Element.aqua),
        cards.charge(4),
        cards.bug(cards.gauge(GaugeSpeed.slow)),
    },
}

return { jelly = card }
