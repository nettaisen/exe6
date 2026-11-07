--!strict
-- CircGun: a gun sight circles the enemy's area until A or 360 ticks, then
-- leaves four shots on the panels it passes (docs/engine/dimming-chip-effects.md
-- §8).

local collision = require("../rules/collision")
local controller = require("@self/controller")

local chip: Chip = {
    codes = { "P", "T", "V" },
    element = "null",
    family = "cursor",
    class = ChipClass.standard,
    rarity = 2,
    mb = 35,
    damage = 150,
    counter = 20,
    cant_counter = true,
    lockout = 0,
    flags = { dimming = true, has_damage = true, standard_library = true, library = true },
    slot_in_limit = 3,
    dimming = controller.hook(controller.variant { period = 2, shots = 4, palette = 0, hit = collision.thrown }),
}

return { circgun = chip }
