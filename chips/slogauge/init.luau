--!strict
-- SloGauge: the custom gauge fills slowly for the rest of the round
-- (lib/gauge_speed/controller).

local gauge_speed = require("../lib/gauge_speed/controller")

local chip: Chip = {
    codes = { "A", "B", "G", "*" },
    element = Element.null, family = Family.null, class = ChipClass.standard,
    rarity = 2, mb = 42, damage = 0, counter = 0, lockout = 0,
    flags = { dimming = true, standard_library = true, library = true },
    slot_in_limit = 1,
    dimming = gauge_speed.slow,
}

return { slogauge = chip }
