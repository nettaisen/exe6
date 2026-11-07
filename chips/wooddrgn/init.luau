--!strict
-- WoodDrgn: a wood dragon that dives down the first column ahead with an
-- enemy in it, growing grass behind it (lib/dragons).

local action = require("../lib/dragons/action")
local dragon = require("../lib/dragons/dragon")
local lockon = require("../rules/lockon")
local sparks = require("../lib/sparks")

local chip: Chip = {
    codes = { "G", "T", "V" },
    element = Element.wood, family = Family.wood, class = ChipClass.standard,
    rarity = 3, mb = 48, damage = 130, counter = 30, lockout = 0,
    flags = { has_damage = true, standard_library = true, library = true },
    slot_in_limit = 3,
    -- No Beast rush; its lock-on mode (rules/lockon).
    beast = { rush = false, lockon = lockon.cannon },
    action = action.action {
        dragon = dragon.variant {
            speed = 0x4_0000,
            palette = 9,
            hit_mod = { flinch = true, flash = true },
            spark = sparks.wood,
            panel = PanelType.grass,
            delays = { 3, 6, 9, 12 },
        },
    },
}

return { wooddrgn = chip }
