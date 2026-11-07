--!strict
-- Mine: a mine that hops among the enemy's free panels for two seconds,
-- then hides where it stopped and blows up under what touches it
-- (./controller, ./land_mine).

local controller = require("@self/controller")

local chip: Chip = {
    codes = { "A", "S", "T" },
    element = Element.null, family = Family.summon, class = ChipClass.standard,
    rarity = 2, mb = 28, damage = 200, counter = 50, cant_counter = true, lockout = 0,
    flags = { dimming = true, has_damage = true, standard_library = true, library = true },
    slot_in_limit = 3,
    dimming = controller.hook,
}

return { mine = chip }
