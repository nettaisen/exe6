--!strict
-- The charged shot of the patch card dark-megaman
-- (`patch_cards/dark_megaman/charge`): the chip DrkSword. The original's
-- weapon routine 0x8a (`sub_801257C`) loads the chip into the attack
-- (`loc_80126EA`, lib/weapon's `chip`) and starts what its use starts.

local weapon = require("../../lib/weapon")
local dark_sword = require("../../chips/dark_sword").dark_sword

return new.weapon {
    id = "patch_cards/dark_megaman/charge",
    -- The charge table's row 0x8a, by Charge 0 to 7: past 4 it reads on
    -- into the next routine's row, as the original's table does.
    charge_ticks = { 200, 190, 180, 175, 170, 0, 0, 0 },
    setup = function(navi: Object)
        return weapon.chip(navi, dark_sword)
    end,
}
