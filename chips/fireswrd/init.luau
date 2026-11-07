--!strict
-- FireSwrd: a fire slash on the column ahead.

local attachment = require("../objects/attachment")
local lockon = require("../rules/lockon")
local parts = require("../lib/swords/parts")
local regions = require("@exelib/regions")
local slash = require("../lib/swords/slash")
local slashes = require("../navis/megaman/forms/slashcross/slashes")
local fire_sword_sprite = asset.sprite("fire-sword")
local sword_slash_sprite = asset.sprite("sword-slash")

-- The slash over a column.
local WIDE_SLASH = new.effect { sprite = sword_slash_sprite, anim = 0, palette = 0, steps = 13 }
-- FireSwrd's blade (the original's attachment row 0x19).
local FIRE_BLADE = attachment.look { sprite = fire_sword_sprite, palette = 0 }

-- Its charged slash in SlashCross: over a column, in palette 1, its own blade.
local CHARGED = slashes.slash {
    wave = slashes.wave { region = regions.wide, sprite = sword_slash_sprite, anim = 0, palette = 1 },
    blade = FIRE_BLADE,
    sound = parts.swing,
    lockon = lockon.widesht,
}

local chip: Chip = {
    codes = { "F", "O", "Z" },
    element = Element.fire,
    family = Family.fire,
    class = ChipClass.standard,
    rarity = 1,
    mb = 30,
    damage = 140,
    counter = 30,
    lockout = 0,
    flags = { has_damage = true, standard_library = true, library = true },
    beast = { lockon = lockon.widesht },
    slot_in_limit = 3,
    traits = { element_sword = true },
    action = slash.action {
        id = "fireswrd/action",
        blade = FIRE_BLADE,
        hit = { region = regions.wide, collision = parts.slashes_navis, hit_mod = { flinch = true, flash = true } },
        effect = WIDE_SLASH,
        effect_palette = 1,
        sound = parts.swing,
        charged = CHARGED,
    },
}

return { fireswrd = chip }
