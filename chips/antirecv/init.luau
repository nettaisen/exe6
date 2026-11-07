--!strict
-- AntiRecv: a hidden trap that turns the other side's next recovery into
-- damage (`sub_800E2FC` and Roll's `sub_80E192C`, with the counterattack
-- in ./controller). The controller that sets it is the trap chips'
-- (lib/traps/controller); it sets no object of its own.

local traps = require("../lib/traps/controller")

local chip: Chip = {
    codes = { "A", "F", "V", "*" },
    element = "null",
    family = "null",
    class = ChipClass.standard,
    rarity = 2,
    mb = 37,
    damage = 0,
    counter = 30,
    cant_counter = true,
    lockout = 0,
    flags = { dimming = true, standard_library = true, library = true },
    slot_in_limit = 1,
    trap = TrapKind.anti_recovery,
    dimming = traps.hook(),
}

return { antirecv = chip }
