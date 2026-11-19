--!strict
-- GreatYo (YoYo's Program Advance): YoYo's throw (chips/yo_yo/throw.luau)
-- of a controller that sends three yoyos, one on each row, which roll out
-- four panels, spin for five rounds and move together.

local throw = require("./yo_yo/throw")
local yoyo = require("./yo_yo/yo_yo")
local yoyo_chip = require("./yo_yo").yo_yo

local chip: Chip = {
    codes = { "A", "B", "C", "*" },
    element = Element.null,
    family = Family.program_advance,
    class = ChipClass.program_advance,
    rarity = 0,
    mb = 5,
    damage = 100,
    counter = 10,
    lockout = 0,
    flags = { has_damage = true, library = true },
    slot_in_limit = 1,
    program_advances = { { order = 27, code_run = { chip = yoyo_chip, count = 3 } } },
    action = throw.action { id = "great_yo_yo/action", throw = yoyo.three { panels = 4, rounds = 5 } },
}

return { great_yo_yo = chip }
