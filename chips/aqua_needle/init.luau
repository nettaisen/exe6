--!strict
-- AquaNdl1-3: a volley of three aqua needles dropped on the enemies'
-- panels (./action), each level's needles in its own colors.

local action = require("@self/action")

local chips: { [string]: Chip } = {
    aqua_needle_1 = {
        codes = { "C", "J", "P" },
        element = Element.aqua, family = Family.aqua, class = ChipClass.standard,
        rarity = 0, mb = 31, damage = 40, counter = 30, lockout = 0,
        flags = { has_damage = true, standard_library = true, library = true },
        slot_in_limit = 3,
        action = action.action { palette = 0 },
    },
    aqua_needle_2 = {
        codes = { "F", "K", "T" },
        element = Element.aqua, family = Family.aqua, class = ChipClass.standard,
        rarity = 1, mb = 35, damage = 60, counter = 30, lockout = 0,
        flags = { has_damage = true, standard_library = true, library = true },
        slot_in_limit = 3,
        action = action.action { palette = 4 },
    },
    aqua_needle_3 = {
        codes = { "A", "L", "U" },
        element = Element.aqua,
        family = Family.aqua,
        class = ChipClass.standard,
        rarity = 2,
        mb = 39,
        damage = 80,
        counter = 30,
        lockout = 0,
        flags = { has_damage = true, standard_library = true, library = true },
        slot_in_limit = 3,
        action = action.action { id = "aqua_needle_3/action", palette = 8 },
    },
}

return chips
