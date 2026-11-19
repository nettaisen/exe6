--!strict
-- WaveArm1, WaveArm2 and WaveArm3: a shock wave (wave.luau) rolling from
-- the panel ahead that steers toward an enemy's row (strike.luau).

local strike = require("@self/strike")
local wave = require("@self/wave")

-- The wave (`byte_80C6B00`'s rows 0xC to 0xE, one a chip, alike): its
-- animation looping every 17 steps; quick, it steers toward an enemy's
-- row.
local WAVE = wave.variant { anim = 1, steps = 17, ticks = 6, quick = true, steers = true }

local wave_arm_1: Chip = {
    codes = { "E", "F", "G" },
    element = Element.null,
    family = Family.null,
    class = ChipClass.standard,
    rarity = 0,
    mb = 15,
    damage = 80,
    counter = 30,
    lockout = 0,
    flags = { has_damage = true, standard_library = true, library = true },
    slot_in_limit = 3,
    action = strike.action { id = "wave_arm_1/action", wave = WAVE },
}

local wave_arm_2: Chip = {
    codes = { "L", "M", "N" },
    element = Element.null,
    family = Family.null,
    class = ChipClass.standard,
    rarity = 1,
    mb = 22,
    damage = 120,
    counter = 30,
    lockout = 0,
    flags = { has_damage = true, standard_library = true, library = true },
    slot_in_limit = 3,
    action = strike.action { id = "wave_arm_2/action", wave = WAVE },
}

local wave_arm_3: Chip = {
    codes = { "R", "S", "T" },
    element = Element.null,
    family = Family.null,
    class = ChipClass.standard,
    rarity = 2,
    mb = 29,
    damage = 160,
    counter = 30,
    lockout = 0,
    flags = { has_damage = true, standard_library = true, library = true },
    slot_in_limit = 3,
    action = strike.action { id = "wave_arm_3/action", wave = WAVE },
}

return { wave_arm_1 = wave_arm_1, wave_arm_2 = wave_arm_2, wave_arm_3 = wave_arm_3 }
