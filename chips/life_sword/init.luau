--!strict
-- LifeSrd: a big slash on the two columns ahead; the Program Advance of Sword, WideSwrd, LongSwrd (or
-- WideBlde, LongBlde).

local lockon = require("../rules/lockon")
local long_blade = require("./long_blade").long_blade
local long_sword = require("./long_sword").long_sword
local parts = require("../lib/swords/parts")
local regions = require("@exelib/regions")
local slash = require("../lib/swords/slash")
local slashes = require("../navis/megaman/forms/slash_cross/slashes")
local sword = require("./sword").sword
local wide_blade = require("./wide_blade").wide_blade
local wide_sword = require("./wide_sword").wide_sword
local big_slash_sprite = asset.sprite("big_slash")

-- The big slash.
local BIG_SLASH = new.effect { sprite = big_slash_sprite, anim = 0, palette = 0, steps = 15 }

-- Its charged slash in SlashCross: the big slash over two columns.
local CHARGED = slashes.slash {
    wave = slashes.wave { region = regions.wide_long, sprite = big_slash_sprite, anim = 0 },
    blade = parts.blade,
    sound = parts.big_swing,
    lockon = lockon.dark_sword,
}

local chip: Chip = {
    codes = { "A", "B", "C", "*" },
    element = Element.null,
    family = Family.program_advance,
    class = ChipClass.program_advance,
    rarity = 0,
    mb = 5,
    damage = 400,
    counter = 40,
    lockout = 0,
    flags = { has_damage = true, library = true },
    beast = { lockon = lockon.dark_sword },
    slot_in_limit = 1,
    program_advances = {
        { order = 0, sequence = { sword, wide_sword, long_sword } },
        { order = 1, sequence = { sword, wide_blade, long_blade } },
    },
    action = slash.action {
        id = "life_sword/action",
        blade = parts.blade,
        hit = { region = regions.wide_long, collision = parts.slashes_navis, hit_mod = { flinch = true, flash = true } },
        effect = BIG_SLASH,
        sound = parts.big_swing,
        charged = CHARGED,
    },
}

return { life_sword = chip }
