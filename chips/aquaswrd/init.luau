--!strict
-- AquaSwrd: an aqua slash on the column ahead.

local attachment = require("../objects/attachment")
local lockon = require("../rules/lockon")
local parts = require("../lib/swords/parts")
local regions = require("@exelib/regions")
local slash = require("../lib/swords/slash")
local slashes = require("../navis/megaman/forms/slashcross/slashes")
local aqua_sword_sprite = asset.sprite("aqua-sword")
local sword_slash_sprite = asset.sprite("sword-slash")

-- The slash over a column.
local WIDE_SLASH = new.effect { sprite = sword_slash_sprite, anim = 0, palette = 0, steps = 13 }
-- AquaSwrd's blade (row 0x1A).
local AQUA_BLADE = attachment.look { sprite = aqua_sword_sprite, palette = 0 }

-- Its charged slash in SlashCross: over a column, in palette 2, its own blade.
local CHARGED = slashes.slash {
    wave = slashes.wave { region = regions.wide, sprite = sword_slash_sprite, anim = 0, palette = 2 },
    blade = AQUA_BLADE,
    sound = parts.swing,
    lockon = lockon.widesht,
}

local chip: Chip = {
    codes = { "A", "I", "Y" },
    element = "aqua",
    family = "aqua",
    class = "standard",
    rarity = 2,
    mb = 32,
    damage = 160,
    hit_param = 30,
    lockout = 0,
    flags = { has_damage = true, standard_library = true, library = true },
    beast = { lockon = lockon.widesht },
    slot_in_limit = 3,
    traits = { element_sword = true },
    action = slash.action {
        id = "aquaswrd/action",
        blade = AQUA_BLADE,
        hit = { region = regions.wide, collision = parts.slashes_navis, hit_mod = 3 },
        effect = WIDE_SLASH,
        effect_palette = 2,
        sound = parts.swing,
        charged = CHARGED,
    },
}

return { aquaswrd = chip }
