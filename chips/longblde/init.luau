--!strict
-- LongBlde: LongSwrd's slash, stronger.

local lockon = require("../rules/lockon")
local parts = require("../lib/swords/parts")
local regions = require("@exelib/regions")
local slash = require("../lib/swords/slash")
local slashes = require("../navis/megaman/forms/slashcross/slashes")
local sword_slash_sprite = asset.sprite("sword-slash")

-- LongBlde's slash.
local LONG_BLADE_SLASH = new.effect { sprite = sword_slash_sprite, anim = 1, palette = 5, steps = 13 }

-- Its charged slash in SlashCross: over two panels, in palette 5.
local CHARGED = slashes.slash {
    wave = slashes.wave { region = regions.long, sprite = sword_slash_sprite, anim = 1, palette = 5 },
    blade = parts.blade,
    sound = parts.swing,
    lockon = lockon.firebrn1,
}

local chip: Chip = {
    codes = { "B", "M", "V" },
    element = "null",
    family = "sword",
    class = ChipClass.standard,
    rarity = 3,
    mb = 38,
    damage = 150,
    counter = 30,
    lockout = 0,
    flags = { has_damage = true, standard_library = true, library = true },
    beast = { lockon = lockon.firebrn1 },
    slot_in_limit = 3,
    action = slash.action {
        id = "longblde/action",
        blade = parts.blade,
        hit = { region = regions.long, collision = parts.slashes_navis, hit_mod = { flinch = true, flash = true } },
        effect = LONG_BLADE_SLASH,
        sound = parts.swing,
        charged = CHARGED,
    },
}

return { longblde = chip }
