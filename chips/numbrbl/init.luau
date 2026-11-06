--!strict
-- NumbrBl: a cut-in chip whose NumberMan sets four balls rolling down the
-- user's row; its damage is the last two digits of the user's HP
-- (docs/engine/dimming-chip-effects.md §15).

local controller = require("@self/controller")

local chip: Chip = {
    codes = { "N" },
    element = "null",
    family = "null",
    class = "standard",
    rarity = 4,
    mb = 69,
    damage = { formula = "hp_last_digits" },
    hit_param = 138,
    lockout = 0,
    flags = {
        dimming = true,
        has_damage = true,
        standard_library = true,
        damage_shown_variable = true,
        library = true,
        variable_damage = true,
    },
    slot_in_limit = 1,
    dimming = controller.hook(4),
}

return { numbrbl = chip }
