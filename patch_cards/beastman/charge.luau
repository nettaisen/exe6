--!strict
-- The charged shot of the patch card beastman
-- (`patch_cards/beastman/charge`): the chip StepSwrd. The original's weapon
-- routine 0x5c (`sub_801238C`) loads the chip into the attack
-- (`loc_80126EA`, lib/weapon's `chip`) and starts what its use starts.

local weapon = require("../../lib/weapon")
local step_sword = require("../../chips/step_sword").step_sword

return new.weapon {
    id = "patch_cards/beastman/charge",
    -- The charge table's row 0x5c, by Charge 0 to 7: past 4 it reads on
    -- into the next routine's row, as the original's table does.
    charge_ticks = { 130, 120, 110, 105, 100, 180, 170, 160 },
    setup = function(navi: Object)
        return weapon.chip(navi, step_sword)
    end,
}
