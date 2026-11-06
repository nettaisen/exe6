--!strict
-- AquaNdl1-3: a volley of three aqua needles dropped on the enemies'
-- panels (./action), each level's needles in its own colors.

local action = require("@self/action")

local chips: { [string]: Chip } = {
    aquandl1 = {
        codes = { "C", "J", "P" },
        element = "aqua", family = "aqua", class = "standard",
        rarity = 0, mb = 31, damage = 40, counter = 30, lockout = 0,
        flags = { has_damage = true, standard_library = true, library = true },
        slot_in_limit = 3,
        action = action.action { palette = 0 },
    },
    aquandl2 = {
        codes = { "F", "K", "T" },
        element = "aqua", family = "aqua", class = "standard",
        rarity = 1, mb = 35, damage = 60, counter = 30, lockout = 0,
        flags = { has_damage = true, standard_library = true, library = true },
        slot_in_limit = 3,
        action = action.action { palette = 4 },
    },
    aquandl3 = {
        codes = { "A", "L", "U" },
        element = "aqua",
        family = "aqua",
        class = "standard",
        rarity = 2,
        mb = 39,
        damage = 80,
        counter = 30,
        lockout = 0,
        flags = { has_damage = true, standard_library = true, library = true },
        slot_in_limit = 3,
        action = action.action { id = "aquandl3/action", palette = 8 },
    },
}

return chips
