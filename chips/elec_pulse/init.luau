--!strict
-- ElcPuls1-3 and DestPuls: an electric pulse held out over the panel ahead
-- and the column past it, pulling what it hits (./action, ./pulse).

local action = require("@self/action")
local pulse = require("@self/pulse")
local lockon = require("../rules/lockon")
local statuses = require("../rules/status")

-- Every pulse lasts 60 ticks; the navi holds it out 5 less, or 5 for the
-- original's second look (ElcPuls2's).
local TICKS = 0x3C
local HOLD, SHORT_HOLD = TICKS - 5, 5

local elec_pulse_1: Chip = {
    codes = { "J", "L", "S" },
    element = Element.elec,
    family = Family.elec,
    class = ChipClass.standard,
    rarity = 0,
    mb = 32,
    damage = 100,
    counter = 30,
    lockout = 0,
    flags = { has_damage = true, standard_library = true, library = true },
    beast = { lockon = lockon.elec_pulse_1 },
    slot_in_limit = 3,
    action = action.action {
        id = "elec_pulse_1/action",
        pulse = pulse.variant { hit_mod = { flinch = true }, status = statuses.paralyze_90, ticks = TICKS, palette = 1 },
        hold = HOLD,
    },
}

local elec_pulse_2: Chip = {
    codes = { "A", "E", "J" },
    element = Element.elec,
    family = Family.elec,
    class = ChipClass.standard,
    rarity = 1,
    mb = 36,
    damage = 120,
    counter = 30,
    lockout = 0,
    flags = { has_damage = true, standard_library = true, library = true },
    beast = { lockon = lockon.elec_pulse_1 },
    slot_in_limit = 3,
    action = action.action {
        id = "elec_pulse_2/action",
        pulse = pulse.variant { hit_mod = { flinch = true, forward = true, drag = true }, status = nil, ticks = TICKS, palette = 2 },
        hold = SHORT_HOLD,
    },
}

local elec_pulse_3: Chip = {
    codes = { "A", "J", "S" },
    element = Element.elec,
    family = Family.elec,
    class = ChipClass.standard,
    rarity = 2,
    mb = 40,
    damage = 140,
    counter = 30,
    lockout = 0,
    flags = { has_damage = true, standard_library = true, library = true },
    beast = { lockon = lockon.elec_pulse_1 },
    slot_in_limit = 3,
    action = action.action {
        id = "elec_pulse_3/action",
        -- Its hits carry bug 0x18 with argument 1.
        pulse = pulse.variant { hit_mod = { flinch = true, flash = true }, status = nil, ticks = TICKS, palette = 0, bug = 0x18, bug_arg = 1 },
        hold = HOLD,
    },
}

local destroy_pulse: Chip = {
    codes = { "A", "B", "C", "*" },
    element = Element.elec,
    family = Family.program_advance,
    class = ChipClass.program_advance,
    rarity = 0,
    mb = 5,
    damage = 400,
    counter = 10,
    lockout = 20,
    flags = { has_damage = true, library = true },
    beast = { lockon = lockon.elec_pulse_1 },
    slot_in_limit = 1,
    program_advances = {
        {
            order = 4,
            sequence = { elec_pulse_1, elec_pulse_2, elec_pulse_3 },
        },
    },
    action = action.action {
        id = "destroy_pulse/action",
        -- Its hits carry the HP bug 0xF6.
        pulse = pulse.variant { hit_mod = {}, status = statuses.paralyze_150, ticks = TICKS, palette = 3, bug = 0xF6 },
        hold = HOLD,
    },
}

return { elec_pulse_1 = elec_pulse_1, elec_pulse_2 = elec_pulse_2, elec_pulse_3 = elec_pulse_3, destroy_pulse = destroy_pulse }
