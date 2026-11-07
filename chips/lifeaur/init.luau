--!strict
-- LifeAur: a cut-in chip that surrounds the user with an aura that stops
-- every hit of less than 200 for a while (lib/barriers).

local barrier_chips = require("../lib/barriers/controller")
local barriers = require("../lib/barriers")

local chip: Chip = {
    codes = { "U" },
    element = Element.null, family = Family.null, class = ChipClass.standard,
    rarity = 4, mb = 70, damage = 0, counter = 0, lockout = 0,
    flags = { dimming = true, standard_library = true, library = true },
    slot_in_limit = 1,
    dimming = barrier_chips.hook(barriers.life_aura),
}

return { lifeaur = chip }
