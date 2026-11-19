--!strict
-- PwrWave1, PwrWave2 and PwrWave3 (WaveArm's Program Advances): WaveArm's
-- strike (chips/wave_arm/strike.luau) with a straight wave, and two more
-- from the navi's own column along the rows above and below.

local strike = require("./wave_arm/strike")
local wave = require("./wave_arm/wave")
local wavearm_chips = require("./wave_arm")

-- The wave (`byte_80C6B00`'s row 0xF): its animation looping every 17
-- steps; quick, straight.
local WAVE = wave.variant { anim = 1, steps = 17, ticks = 6, quick = true }

local power_wave_1: Chip = {
    codes = { "A", "B", "C", "*" },
    element = Element.null,
    family = Family.program_advance,
    class = ChipClass.program_advance,
    rarity = 0,
    mb = 5,
    damage = 400,
    counter = 10,
    lockout = 0,
    flags = { has_damage = true, library = true },
    slot_in_limit = 1,
    program_advances = { { order = 31, code_run = { chip = wavearm_chips.wave_arm_1, count = 3 } } },
    action = strike.action { id = "power_wave_1/action", wave = WAVE, three_rows = true },
}

local power_wave_2: Chip = {
    codes = { "A", "B", "C", "*" },
    element = Element.null,
    family = Family.program_advance,
    class = ChipClass.program_advance,
    rarity = 0,
    mb = 5,
    damage = 500,
    counter = 10,
    lockout = 0,
    flags = { has_damage = true, library = true },
    slot_in_limit = 1,
    program_advances = { { order = 32, code_run = { chip = wavearm_chips.wave_arm_2, count = 3 } } },
    action = strike.action { id = "power_wave_2/action", wave = WAVE, three_rows = true },
}

local power_wave_3: Chip = {
    codes = { "A", "B", "C", "*" },
    element = Element.null,
    family = Family.program_advance,
    class = ChipClass.program_advance,
    rarity = 0,
    mb = 5,
    damage = 600,
    counter = 10,
    lockout = 0,
    flags = { has_damage = true, library = true },
    slot_in_limit = 1,
    program_advances = { { order = 33, code_run = { chip = wavearm_chips.wave_arm_3, count = 3 } } },
    action = strike.action { id = "power_wave_3/action", wave = WAVE, three_rows = true },
}

return { power_wave_1 = power_wave_1, power_wave_2 = power_wave_2, power_wave_3 = power_wave_3 }
