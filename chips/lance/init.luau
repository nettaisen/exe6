--!strict
-- Lance: three lances (lance.luau) thrust out of the far column, one per
-- row.

local lance = require("@self/lance")

local chip: Chip = {
    codes = { "A", "R", "W", "*" },
    element = Element.wood, family = Family.wood, class = ChipClass.standard,
    rarity = 3, mb = 42, damage = 150, counter = 30, lockout = 10,
    flags = { has_damage = true, standard_library = true, library = true },
    slot_in_limit = 3,
    instant = lance.instant,
}

return { lance = chip }
