--!strict
-- MoonBld: a spin with a blade that sweeps the eight panels around the
-- navi (./action, ./blade).

local action = require("@self/action")
local lockon = require("../rules/lockon")
local parts = require("../lib/swords/parts")
local regions = require("@exelib/regions")
local slashes = require("../navis/megaman/forms/slashcross/slashes")
local moon_blade_sprite = asset.sprite("moon-blade")

-- Its charged slash in SlashCross: the moon blade's ring, its hits giving
-- a bug (code 0x18, argument 1); no blade.
local CHARGED = slashes.slash {
    wave = slashes.wave {
        region = regions.ring,
        sprite = moon_blade_sprite,
        anim = 0,
        -- Its blade comes round every 10 of its sprite's steps.
        animates = 10,
        bug = 0x18,
        bug_arg = 1,
    },
    sound = parts.swing,
    lockon = lockon.moonbld,
}

local chip: Chip = {
    codes = { "A", "M", "T" },
    element = "null",
    family = "sword",
    class = "standard",
    rarity = 2,
    mb = 35,
    damage = 130,
    counter = 30,
    lockout = 0,
    flags = { has_damage = true, standard_library = true, library = true },
    beast = { lockon = lockon.moonbld },
    slot_in_limit = 3,
    -- (SlashCross's A-charge sends its ring as a sword wave.)
    action = action.action { id = "moonbld/action", charged = CHARGED },
}

return { moonbld = chip }
