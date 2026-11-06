--!strict
-- ElemSwrd: slashes every opposing navi on a grass, ice or volcano panel where it stands.

local parts = require("../lib/swords/parts")
local strike = require("../lib/swords/strike")

local chip: Chip = {
    codes = { "J", "M", "U" },
    element = "null", family = "null", class = "standard",
    rarity = 1, mb = 43, damage = 220, hit_param = 30, lockout = 0,
    flags = { has_damage = true, standard_library = true, library = true },
    slot_in_limit = 3,
    action = strike.action { blade = parts.blade, finds = "on_element_panels", effect_palette = 8 },
}

return { elemswrd = chip }
