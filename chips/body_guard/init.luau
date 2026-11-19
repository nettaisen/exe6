--!strict
-- BodyGrd, the Program Advance of AntiNavi, AntiSwrd and AntiDmg: a hidden
-- trap that swallows the next hit of 10 damage or more and answers with
-- its counter (the damage intake's `sub_802CEF4`; the counter is the role
-- `actions.body_guard_counter`). Its controller is the trap chips'
-- (lib/traps/controller); it sets no object of its own.

local traps = require("../lib/traps/controller")
local anti_damage = require("./anti_damage").anti_damage
local anti_navi = require("./anti_navi").anti_navi
local anti_sword = require("./anti_sword").anti_sword

local chip: Chip = {
    codes = { "A", "B", "C", "*" },
    element = Element.null,
    family = Family.program_advance,
    class = ChipClass.program_advance,
    rarity = 0,
    mb = 5,
    damage = 100,
    counter = 5,
    cant_counter = true,
    lockout = 0,
    flags = { dimming = true, has_damage = true, library = true },
    slot_in_limit = 1,
    program_advances = { { order = 3, sequence = { anti_navi, anti_sword, anti_damage } } },
    trap = TrapKind.body_guard,
    dimming = traps.hook(),
}

return { body_guard = chip }
