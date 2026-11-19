--!strict
-- The charged shot of the patch card blizman (`patch_cards/blizzardman/charge`):
-- the chip BlzrdBal. The original's weapon routine 0x5d (`sub_8012396`)
-- loads the chip into the attack (`loc_80126EA`, lib/weapon's `chip`) and
-- starts what its use starts.

local weapon = require("../../lib/weapon")
local blizzard_ball = require("../../chips/blizzard_ball").blizzard_ball

return new.weapon {
    id = "patch_cards/blizzardman/charge",
    -- The charge table's row 0x5d, by Charge 0 to 7: past 4 it reads on
    -- into the next routine's row, as the original's table does.
    charge_ticks = { 180, 170, 160, 155, 150, 150, 140, 130 },
    setup = function(navi: Object)
        return weapon.chip(navi, blizzard_ball)
    end,
}
