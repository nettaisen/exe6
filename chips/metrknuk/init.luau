--!strict
-- MetrKnuk: a giga cut-in chip that rains 16 fists on and around the
-- enemies, cracking the panels (docs/engine/dimming-chip-effects.md §18).
-- (The record's extra flag bytes 0x04 and 0x10 are read by no battle
-- routine.)

local controller = require("@self/controller")

local chip: Chip = {
    codes = { "N" },
    element = Element.null, family = Family["break"], class = ChipClass.giga,
    -- The version whose saves hold it (rules/folder).
    version = Version.falzar,
    rarity = 4, mb = 90, damage = 100, counter = 20, cant_counter = true, lockout = 0,
    flags = { dimming = true, has_damage = true, library = true },
    slot_in_limit = 1,
    dimming = controller.hook,
}

return { metrknuk = chip }
