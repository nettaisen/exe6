--!strict
-- FstGauge: the custom gauge fills fast for the rest of the round
-- (lib/gauge_speed/controller).

local gauge_speed = require("../lib/gauge_speed/controller")

local chip: Chip = {
    codes = { "E", "M", "R", "*" },
    element = Element.null, family = Family.null, class = "standard",
    rarity = 2, mb = 48, damage = 0, counter = 0, lockout = 0,
    flags = { dimming = true, standard_library = true, library = true },
    slot_in_limit = 1,
    dimming = gauge_speed.fast,
}

return { fstgauge = chip }
