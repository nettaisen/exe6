--!strict
-- HeatDrgn: a fire dragon that dives down the first column ahead with an
-- enemy in it (lib/dragons).

local action = require("../lib/dragons/action")
local dragon = require("../lib/dragons/dragon")
local lockon = require("../rules/lockon")
local sparks = require("../lib/sparks")

local chip: Chip = {
    codes = { "G", "R", "T" },
    element = "fire", family = "fire", class = ChipClass.standard,
    rarity = 2, mb = 40, damage = 140, counter = 30, lockout = 0,
    flags = { has_damage = true, standard_library = true, library = true },
    slot_in_limit = 3,
    -- No Beast rush; its lock-on mode (rules/lockon).
    beast = { rush = false, lockon = lockon.cannon },
    action = action.action {
        dragon = dragon.variant {
            speed = 0x4_0000,
            palette = 0,
            hit_mod = { flinch = true, flash = true },
            spark = sparks.fire,
            panel = false,
            delays = { 3, 6, 9, 12 },
        },
    },
}

return { heatdrgn = chip }
