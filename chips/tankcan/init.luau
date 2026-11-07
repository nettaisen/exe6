--!strict
-- TankCan1-3: a shell from the panel ahead (action.luau, shell.luau) that
-- staggers what it hits, or, off the far edge, blasts and cracks the last
-- column and sets off three explosions there. The three differ only in
-- their damage.

local lockon = require("../rules/lockon")
local tankcan = require("@self/action")

-- The shell: kind 0's hit modifier, cracking, no damage shift (the chips'
-- parameters 0x100).
local SHELL = { hit_mod = { flinch = true, flash = true, back_far = true, drag = true }, cracks = true, shift = 0 }

local chips: { [string]: Chip } = {
    tankcan1 = {
        codes = { "A", "G", "R" },
        element = Element.null, family = Family.null, class = "standard",
        rarity = 0, mb = 17, damage = 120, counter = 20, lockout = 0,
        flags = { has_damage = true, standard_library = true, library = true },
        slot_in_limit = 3,
        -- The Beast rush, and its lock-on mode (rules/lockon).
        beast = { lockon = lockon.cannon },
        action = tankcan.action { shell = SHELL },
    },
    tankcan2 = {
        codes = { "L", "S", "V" },
        element = Element.null, family = Family.null, class = "standard",
        rarity = 1, mb = 28, damage = 160, counter = 20, lockout = 0,
        flags = { has_damage = true, standard_library = true, library = true },
        slot_in_limit = 3,
        -- The Beast rush, and its lock-on mode (rules/lockon).
        beast = { lockon = lockon.cannon },
        action = tankcan.action { shell = SHELL },
    },
    tankcan3 = {
        codes = { "B", "M", "P" },
        element = Element.null, family = Family.null, class = "standard",
        rarity = 2, mb = 39, damage = 200, counter = 20, lockout = 0,
        flags = { has_damage = true, standard_library = true, library = true },
        slot_in_limit = 3,
        -- The Beast rush, and its lock-on mode (rules/lockon).
        beast = { lockon = lockon.cannon },
        action = tankcan.action { shell = SHELL },
    },
}

return chips
