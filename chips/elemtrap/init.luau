--!strict
-- ElemTrap: a hidden trap over the whole field that the other side's
-- first fire, aqua, elec or wood hit springs: a counterattack of that
-- element on every panel the enemy stands on (./trap, ./strike; the
-- controller is the trap chips', lib/traps/controller).

local trap = require("@self/trap")
local traps = require("../lib/traps/controller")

local chip: Chip = {
    codes = { "G", "S", "U", "*" },
    element = "null", family = "null", class = ChipClass.standard,
    rarity = 2, mb = 42, damage = 240, counter = 30, cant_counter = true, lockout = 0,
    flags = { dimming = true, has_damage = true, standard_library = true, library = true },
    slot_in_limit = 1,
    dimming = traps.hook(traps.trap { set = trap.set }),
}

return { elemtrap = chip }
