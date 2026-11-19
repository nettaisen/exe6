--!strict
-- NeedlArm's charged shot (`needle_arm/charge`): the weapon the chip makes
-- the navi's charged shot (lib/navi_boost/controller; the original's weapon
-- routine 0x24, `sub_8011ED0`). It is AquaNdl1's volley (chips/aqua_needle:
-- the original's parameter bytes are 0, the first palette) for 40 Aqua.
-- Sticky: a form's own charged shot doesn't replace it, and while the navi
-- has it a Beast buster gives way to the plain one.

local aquandl_chips = require("../aqua_needle")
local charge = require("../../lib/navi_boost/charge")

-- The attack's element byte: Aqua.
local ELEMENT = Element.aqua
local DAMAGE = 0x28

-- `sub_8011ED0`.
local function setup(navi: Object): Action
    charge.prepare(navi, ELEMENT, DAMAGE)
    return assert(aquandl_chips.aqua_needle_1.action)
end

return new.weapon {
    id = "needle_arm/charge",
    charge_ticks = { 100, 100, 100, 100, 100, 120, 120, 120 }, -- by Charge 0..7; past 4, the next routine's row
    setup = setup,
    sticky = true,
}
