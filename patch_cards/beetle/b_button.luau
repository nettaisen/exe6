--!strict
-- The B button of the patch card beetle (`patch_cards/beetle/b_button`): the
-- chip MiniBomb. The original's weapon routine 0x7d (`sub_80124EA`) loads
-- the chip into the attack (`loc_80126EA`, lib/weapon's `chip`) and starts
-- what its use starts.

local weapon = require("../../lib/weapon")
local mini_bomb = require("../../chips/mini_bomb").mini_bomb

return new.weapon {
    id = "patch_cards/beetle/b_button",
    -- The charge table's row 0x7d, by Charge 0 to 7: past 4 it reads on
    -- into the next routine's row, as the original's table does.
    charge_ticks = { 60, 55, 50, 45, 40, 100, 90, 80 },
    setup = function(navi: Object)
        return weapon.chip(navi, mini_bomb)
    end,
}
