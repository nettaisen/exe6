--!strict
-- Snake: a cut-in chip whose snakes leap out of every hole on the user's
-- side at the nearest enemy (docs/engine/dimming-chip-effects.md §13).

local controller = require("@self/controller")

local chip: Chip = {
    codes = { "H", "M", "L" },
    element = Element.null, family = Family.null, class = ChipClass.standard,
    rarity = 3, mb = 34, damage = 30, counter = 5, cant_counter = true, lockout = 0,
    flags = { dimming = true, has_damage = true, standard_library = true, library = true },
    slot_in_limit = 3,
    dimming = controller.hook,
}

return { snake = chip }
