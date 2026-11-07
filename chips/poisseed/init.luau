--!strict
-- PoisSeed: a seed that turns the panels it lands on into poison.

local seed = require("../lib/bombs/seed")
local throw = require("../lib/bombs/throw")
local grab_shot_sprite = asset.sprite("grab-shot")

local chip: Chip = {
    codes = { "H", "N", "P", "*" },
    element = "null",
    family = "null",
    class = ChipClass.standard,
    rarity = 2,
    mb = 37,
    damage = 10,
    counter = 10,
    lockout = 10,
    flags = { standard_library = true, library = true },
    slot_in_limit = 3,
    action = throw.action {
        id = "poisseed/action",
        held = seed.held(3),
        held_anim = 8,
        thrower = seed.thrower(seed.variant {
            element = Element.null,
            palette = 3,
            panel = "poison",
            -- Its sprout (effect 0x3B).
            effect = new.effect { sprite = grab_shot_sprite, anim = 1, palette = 0, steps = 16 },
            sound = asset.sound("panel-poison"),
        }),
    },
}

return { poisseed = chip }
