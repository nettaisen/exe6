--!strict
-- The charged shot of the patch card grndman (`patch_cards/groundman/charge`):
-- the chip DrilArm. The original's weapon routine 0x85 (`sub_8012540`) loads
-- the chip into the attack (`loc_80126EA`, lib/weapon's `chip`) and starts
-- what its use starts.

local weapon = require("../../lib/weapon")
local drill_arm = require("../../chips/drill_arm").drill_arm

return new.weapon {
    id = "patch_cards/groundman/charge",
    -- The charge table's row 0x85, by Charge 0 to 7: past 4 it reads on
    -- into the next routine's row, as the original's table does.
    charge_ticks = { 120, 110, 100, 95, 90, 0, 0, 0 },
    setup = function(navi: Object)
        return weapon.chip(navi, drill_arm)
    end,
}
