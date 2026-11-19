--!strict
-- PuzzlArm's charged shot (`pulse_arm/charge`): the weapon the chip makes
-- the navi's charged shot (lib/navi_boost/controller; the original's weapon
-- routine 0x25, `sub_8011EF0`). It is ElcPuls's pulse (chips/elec_pulse) with
-- parameters no chip has: no hit modifier, paralysis, 60 ticks, ElcPuls1's
-- look, for 100 Elec. Sticky: a form's own charged shot doesn't replace it,
-- and while the navi has it a Beast buster gives way to the plain one.

local action = require("../elec_pulse/action")
local charge = require("../../lib/navi_boost/charge")
local pulse = require("../elec_pulse/pulse")
local statuses = require("../../rules/status")

local pulse_arm = {}

-- The attack's element byte: Elec.
local ELEMENT = Element.elec
local DAMAGE = 0x64
-- The pulse's ticks; the navi holds it out 5 less.
local TICKS = 0x3C

-- The pulse (the original's parameter bytes 0, 0x10, 0x3C, 0).
pulse_arm.action = action.action {
    id = "pulse_arm/charge/action",
    pulse = pulse.variant { hit_mod = {}, status = statuses.paralyze_90, ticks = TICKS, palette = 1 },
    hold = TICKS - 5,
}

-- `sub_8011EF0`.
local function setup(navi: Object): Action
    charge.prepare(navi, ELEMENT, DAMAGE)
    return pulse_arm.action
end

pulse_arm.weapon = new.weapon {
    id = "pulse_arm/charge",
    charge_ticks = { 120, 120, 120, 120, 120, 100, 100, 100 }, -- by Charge 0..7; past 4, the next routine's row
    setup = setup,
    sticky = true,
}

return pulse_arm
