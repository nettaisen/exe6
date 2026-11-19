--!strict
-- PitHocky (AirHocky's Program Advance): AirHocky's flick
-- (chips/air_hockey/flick.luau) of a puck that bounces for 18 steps,
-- leaving a trail.

local flick = require("./air_hockey/flick")
local puck = require("./air_hockey/puck")
local air_hockey = require("./air_hockey").air_hockey

-- The puck (`byte_80C9818`'s row 3): 18 steps, with a trail.
local PUCK = puck.variant { steps = 0x12, own_side = 1, ticks = 6, trail = 0x8318 }

local chip: Chip = {
    codes = {},
    element = Element.null,
    family = Family.program_advance,
    class = ChipClass.program_advance,
    rarity = 0,
    mb = 5,
    damage = 100,
    counter = 5,
    lockout = 0,
    flags = { has_damage = true, library = true },
    slot_in_limit = 1,
    program_advances = { { order = 26, code_run = { chip = air_hockey, count = 3 } } },
    action = flick.action { id = "pit_hockey/action", puck = PUCK, down = true },
}

return { pit_hockey = chip }
