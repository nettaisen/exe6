--!strict
-- JustcOne: a Break fist (strike.luau) falls onto the other side's middle
-- panel and cracks the panels around it.

local strike = require("@self/strike")

local chip: Chip = {
    codes = { "J" },
    element = "null", family = "break", class = ChipClass.standard,
    rarity = 4, mb = 90, damage = 220, counter = 50, cant_counter = true, lockout = 20,
    flags = { has_damage = true, standard_library = true, library = true },
    slot_in_limit = 1,
    instant = strike.instant,
}

return { justcone = chip }
