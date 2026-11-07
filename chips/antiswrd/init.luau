--!strict
-- AntiSwrd: a hidden trap that swallows the next sword hit and answers
-- with its counter (the damage intake's `sub_802CEF4`; the counter is the
-- role `actions.anti_sword_counter`). Its controller is the trap chips'
-- (lib/traps/controller); it sets no object of its own.

local traps = require("../lib/traps/controller")

local chip: Chip = {
    codes = { "A", "R", "Z", "*" },
    element = Element.null,
    family = Family.sword,
    class = ChipClass.standard,
    rarity = 2,
    mb = 33,
    damage = 100,
    counter = 10,
    cant_counter = true,
    lockout = 0,
    flags = { dimming = true, has_damage = true, standard_library = true, library = true },
    slot_in_limit = 1,
    trap = TrapKind.anti_sword,
    dimming = traps.hook(),
}

return { antiswrd = chip }
