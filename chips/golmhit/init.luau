--!strict
-- GolmHit1, GolmHit2, GolmHit3: a golem's fist (golem.luau) leaps onto the
-- column of the nearest of the other side's navis on the user's row and
-- lands on its three panels, Break; in the golem's three palettes.

local golem = require("@self/golem")

local chips: { [string]: Chip } = {
    golmhit1 = {
        codes = { "I", "K", "Y" },
        element = "null", family = "break", class = ChipClass.standard,
        rarity = 0, mb = 17, damage = 140, counter = 30, lockout = 20,
        flags = { has_damage = true, standard_library = true, library = true },
        slot_in_limit = 3,
        instant = golem.instant { palette = 0 },
    },
    golmhit2 = {
        codes = { "D", "P", "U" },
        element = "null", family = "break", class = ChipClass.standard,
        rarity = 1, mb = 27, damage = 190, counter = 30, lockout = 20,
        flags = { has_damage = true, standard_library = true, library = true },
        slot_in_limit = 3,
        instant = golem.instant { palette = 1 },
    },
    golmhit3 = {
        codes = { "H", "M", "V" },
        element = "null", family = "break", class = ChipClass.standard,
        rarity = 2, mb = 37, damage = 250, counter = 30, lockout = 20,
        flags = { has_damage = true, standard_library = true, library = true },
        slot_in_limit = 3,
        instant = golem.instant { palette = 2 },
    },
}

return chips
