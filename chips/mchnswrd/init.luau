--!strict
-- MchnSwrd: slashes every paralyzed opposing navi where it stands.

local parts = require("../lib/swords/parts")
local strike = require("../lib/swords/strike")

local chip: Chip = {
    codes = { "H", "L", "Q" },
    element = Element.null, family = Family.null, class = ChipClass.standard,
    rarity = 0, mb = 37, damage = 200, counter = 30, lockout = 0,
    flags = { has_damage = true, standard_library = true, library = true },
    slot_in_limit = 3,
    action = strike.action { blade = parts.blade, finds = "paralyzed", effect_palette = 7 },
}

return { mchnswrd = chip }
