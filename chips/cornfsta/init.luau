--!strict
-- CornFsta: the Program Advance of three CornShts of a code (or of a
-- run): a cut-in in which the user's stand-in sows a field of bursting
-- corn among the enemies (docs/engine/dimming-chip-effects.md §16).

local controller = require("@self/controller")
local cornsht_chips = require("./cornsht")

local chip: Chip = {
    codes = { "A", "B", "C", "*" },
    element = "wood",
    family = "program_advance",
    class = "program_advance",
    rarity = 0,
    mb = 5,
    damage = 40,
    counter = 10,
    lockout = 20,
    flags = { dimming = true, has_damage = true, library = true },
    slot_in_limit = 1,
    program_advances = {
        { order = 34, code_run = { chip = cornsht_chips.cornsht1, count = 3 } },
        { order = 35, code_run = { chip = cornsht_chips.cornsht2, count = 3 } },
        { order = 36, code_run = { chip = cornsht_chips.cornsht3, count = 3 } },
    },
    dimming = controller.hook,
}

return { cornfsta = chip }
