--!strict
-- Muramasa: a slash on the two panels ahead, as strong as the HP its user lost.

local lockon = require("../rules/lockon")
local parts = require("../lib/swords/parts")
local regions = require("@exelib/regions")
local slash = require("../lib/swords/slash")
local slashes = require("../navis/megaman/forms/slashcross/slashes")
local sword_slash_sprite = asset.sprite("sword-slash")

-- Muramasa's slash.
local MURAMASA_SLASH = new.effect { sprite = sword_slash_sprite, anim = 1, palette = 6, steps = 13 }

-- Its charged slash in SlashCross: over two panels, in palette 6.
local CHARGED = slashes.slash {
    wave = slashes.wave { region = regions.long, sprite = sword_slash_sprite, anim = 1, palette = 6 },
    blade = parts.blade,
    sound = parts.swing,
    lockon = lockon.firebrn1,
}

local chip: Chip = {
    codes = { "M" },
    element = Element.null,
    family = Family.sword,
    class = ChipClass.standard,
    rarity = 3,
    mb = 77,
    damage = { formula = Formula.hp_lost },
    counter = 50,
    lockout = 0,
    flags = { has_damage = true, standard_library = true, damage_shown_variable = true, library = true, variable_damage = true },
    -- (The custom screen shows its damage as "???" only on an A, which it
    -- never comes as.)
    traits = { hides_damage_as_a = true },
    beast = { lockon = lockon.firebrn1 },
    slot_in_limit = 1,
    action = slash.action {
        id = "muramasa/action",
        blade = parts.blade,
        hit = { region = regions.long, collision = parts.slashes_navis, hit_mod = { flinch = true, flash = true } },
        effect = MURAMASA_SLASH,
        sound = parts.swing,
        charged = CHARGED,
    },
}

return { muramasa = chip }
