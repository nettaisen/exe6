--!strict
-- SandWrm1, SandWrm2, SandWrm3: behind each of the other side's navis, a
-- worm (worm.luau) bursts out of the sand and arcs over it toward the
-- user; its level, the chip's (0 to 2), is its palette. (Their records'
-- lock-on mode is 1, without the Beast rush.)

local lockon = require("../rules/lockon")
local worm = require("@self/worm")

local chips: { [string]: Chip } = {
    sandwrm1 = {
        codes = { "A", "G", "L" },
        element = Element.null, family = Family.null, class = ChipClass.standard,
        rarity = 0, mb = 30, damage = 130, counter = 30, lockout = 0,
        flags = { has_damage = true, standard_library = true, library = true },
        beast = { rush = false, lockon = lockon.cannon },
        slot_in_limit = 3,
        instant = worm.instant(0),
    },
    sandwrm2 = {
        codes = { "B", "R", "Y" },
        element = Element.null, family = Family.null, class = ChipClass.standard,
        rarity = 1, mb = 34, damage = 150, counter = 30, lockout = 0,
        flags = { has_damage = true, standard_library = true, library = true },
        beast = { rush = false, lockon = lockon.cannon },
        slot_in_limit = 3,
        instant = worm.instant(1),
    },
    sandwrm3 = {
        codes = { "H", "J", "S" },
        element = Element.null, family = Family.null, class = ChipClass.standard,
        rarity = 2, mb = 38, damage = 170, counter = 30, lockout = 0,
        flags = { has_damage = true, standard_library = true, library = true },
        beast = { rush = false, lockon = lockon.cannon },
        slot_in_limit = 3,
        instant = worm.instant(2),
    },
}

return chips
