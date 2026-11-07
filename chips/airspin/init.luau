--!strict
-- AirSpin1-3: a whirlwind top set down ahead that rolls forward and
-- spins, hitting the panels around it (./action, ./top); each level's top
-- in its own colors spins once more.

local action = require("@self/action")
local top = require("@self/top")

local chips: { [string]: Chip } = {
    airspin1 = {
        codes = { "F", "G", "R" },
        element = Element.null, family = Family.wind, class = ChipClass.standard,
        rarity = 1, mb = 22, damage = 50, counter = 10, lockout = 0,
        flags = { has_damage = true, standard_library = true, library = true },
        slot_in_limit = 3,
        action = action.action { whirlwind = top.sender(0, 2) },
    },
    airspin2 = {
        codes = { "A", "L", "T" },
        element = Element.null, family = Family.wind, class = ChipClass.standard,
        rarity = 2, mb = 29, damage = 50, counter = 10, lockout = 0,
        flags = { has_damage = true, standard_library = true, library = true },
        slot_in_limit = 3,
        action = action.action { whirlwind = top.sender(4, 3) },
    },
    airspin3 = {
        codes = { "N", "O", "T" },
        element = Element.null, family = Family.wind, class = ChipClass.standard,
        rarity = 3, mb = 36, damage = 50, counter = 10, lockout = 0,
        flags = { has_damage = true, standard_library = true, library = true },
        slot_in_limit = 3,
        action = action.action { whirlwind = top.sender(8, 4) },
    },
}

return chips
