--!strict
-- The charged shot of the patch card kendoman
-- (`patch_cards/kendoman/charge`): the chip BambSwrd. The original's weapon
-- routine 0x68 (`sub_8012418`) loads the chip into the attack
-- (`loc_80126EA`, lib/weapon's `chip`) and starts what its use starts.

local weapon = require("../../lib/weapon")
local bamboo_sword = require("../../chips/bamboo_sword").bamboo_sword

return new.weapon {
    id = "patch_cards/kendoman/charge",
    -- The charge table's row 0x68, by Charge 0 to 7: past 4 it reads on
    -- into the next routine's row, as the original's table does.
    charge_ticks = { 100, 90, 80, 75, 70, 100, 90, 80 },
    setup = function(navi: Object)
        return weapon.chip(navi, bamboo_sword)
    end,
}
