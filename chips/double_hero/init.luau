--!strict
-- DblHero: the Program Advance of WideBlde, LongBlde and ProtoMn[SP]: a
-- cut-in in which MegaMan and ProtoMan stand in for the user, MegaMan's
-- ten volleys hitting every enemy panel (docs/engine/dimming-chip-effects.md
-- §17).

local controller = require("@self/controller")
local long_blade = require("./long_blade").long_blade
local protoman_chips = require("./protoman")
local wide_blade = require("./wide_blade").wide_blade

local chip: Chip = {
    codes = { "A", "B", "C", "*" },
    element = Element.null,
    family = Family.program_advance,
    class = ChipClass.program_advance,
    rarity = 0,
    mb = 5,
    damage = 60,
    counter = 10,
    cant_counter = true,
    lockout = 0,
    flags = { dimming = true, library = true },
    slot_in_limit = 1,
    program_advances = { { order = 5, sequence = { wide_blade, long_blade, protoman_chips.protoman_sp } } },
    dimming = controller.hook,
}

return { double_hero = chip }
