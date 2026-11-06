--!strict
-- Sword: a slash on the panel ahead.

local lockon = require("../rules/lockon")
local parts = require("../lib/swords/parts")
local regions = require("@exelib/regions")
local slash = require("../lib/swords/slash")
local slashes = require("../navis/megaman/forms/slashcross/slashes")
local sword_slash_sprite = asset.sprite("sword-slash")

-- Sword's slash over the panel ahead.
local SWORD_SLASH = new.effect { sprite = sword_slash_sprite, anim = 2, palette = 0, steps = 10 }

-- Its charged slash in SlashCross: the plain sword's (the original's row 0): over the panel ahead.
local CHARGED = slashes.slash {
    wave = slashes.wave { region = regions.single, sprite = sword_slash_sprite, anim = 2 },
    blade = parts.blade,
    sound = parts.swing,
    lockon = lockon.thunder,
}

local chip: Chip = {
    codes = { "H", "L", "S", "*" },
    element = "null",
    family = "sword",
    class = "standard",
    rarity = 0,
    mb = 8,
    damage = 80,
    counter = 30,
    lockout = 0,
    flags = { "has_damage", "standard_library", "library" },
    beast = { lockon = lockon.thunder },
    slot_in_limit = 3,
    action = slash.action {
        id = "sword/action",
        blade = parts.blade,
        hit = { region = regions.single, collision = parts.slashes_navis, hit_mod = { flinch = true, flash = true } },
        effect = SWORD_SLASH,
        sound = parts.swing,
        charged = CHARGED,
    },
}

return { sword = chip }
