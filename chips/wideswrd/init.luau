--!strict
-- WideSwrd: a slash on the column ahead.

local lockon = require("../rules/lockon")
local parts = require("../lib/swords/parts")
local regions = require("@exelib/regions")
local slash = require("../lib/swords/slash")
local slashes = require("../navis/megaman/forms/slashcross/slashes")
local sword_slash_sprite = asset.sprite("sword-slash")

-- The slash over a column.
local WIDE_SLASH = new.effect { sprite = sword_slash_sprite, anim = 0, palette = 0, steps = 13 }

-- Its charged slash in SlashCross: over a column.
local CHARGED = slashes.slash {
    wave = slashes.wave { region = regions.wide, sprite = sword_slash_sprite, anim = 0 },
    blade = parts.blade,
    sound = parts.swing,
    lockon = lockon.widesht,
}

local chip: Chip = {
    codes = { "H", "L", "S", "*" },
    element = Element.null,
    family = Family.sword,
    class = "standard",
    rarity = 1,
    mb = 12,
    damage = 80,
    counter = 30,
    lockout = 0,
    flags = { has_damage = true, standard_library = true, library = true },
    beast = { lockon = lockon.widesht },
    slot_in_limit = 3,
    action = slash.action {
        id = "wideswrd/action",
        blade = parts.blade,
        hit = { region = regions.wide, collision = parts.slashes_navis, hit_mod = { flinch = true, flash = true } },
        effect = WIDE_SLASH,
        sound = parts.swing,
        charged = CHARGED,
    },
}

return { wideswrd = chip }
