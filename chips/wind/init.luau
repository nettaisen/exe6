--!strict
-- Wind and Fan: a fan in front of the user that blows a gust along the
-- enemy's rows every 12 ticks for 24 seconds: Wind's pushes away from the
-- enemy's front column, Fan's pulls from the far column
-- (docs/engine/dimming-chip-effects.md §1).

local controller = require("@self/controller")
local fan = require("@self/fan")
local fan_sprite = asset.sprite("fan")

local wind: Chip = {
    codes = { "*" },
    element = Element.null,
    family = Family.wind,
    class = ChipClass.standard,
    rarity = 1,
    mb = 10,
    damage = 0,
    counter = 0,
    lockout = 0,
    flags = { dimming = true, standard_library = true, library = true },
    extra_flags = { free_slot_in = true },
    slot_in_limit = 3,
    dimming = controller.hook(fan.variant {
        palette = 0,
        pulls = false,
        wait = 1,
        hp = 40,
        identity = new.identity {
            id = "wind",
            class = IdentityClass.field_object,
            version = 3,
            ai_index = 1,
            look = { sprite = fan_sprite, anim = 0, palette = 0, shadow = false },
        },
        absorbed = fan.absorbed,
    }),
}

local fan_chip: Chip = {
    codes = { "*" },
    element = Element.null,
    family = Family.wind,
    class = ChipClass.standard,
    rarity = 1,
    mb = 10,
    damage = 0,
    counter = 0,
    lockout = 0,
    flags = { dimming = true, standard_library = true, library = true },
    extra_flags = { free_slot_in = true },
    slot_in_limit = 3,
    dimming = controller.hook(fan.variant {
        palette = 1,
        pulls = true,
        wait = 1,
        hp = 40,
        identity = new.identity {
            id = "fan",
            class = IdentityClass.field_object,
            version = 4,
            ai_index = 1,
            look = { sprite = fan_sprite, anim = 0, palette = 1, shadow = false },
        },
        absorbed = fan.absorbed,
    }),
}

return { wind = wind, fan = fan_chip }
