--!strict
-- ColArmy: every obstacle on the field blinks out, and a soldier
-- (army.luau) takes its panel and fires three shots.

local army = require("@self/army")

local chip: Chip = {
    codes = { "B", "G", "R", "*" },
    element = Element.null, family = Family.null, class = "standard",
    rarity = 2, mb = 25, damage = 40, counter = 30, lockout = 0,
    flags = { has_damage = true, standard_library = true, library = true },
    slot_in_limit = 3,
    instant = army.instant,
}

return { colarmy = chip }
