--!strict
-- The patch cards' invisibility (`patch_cards/invisible_charge`, the
-- original's weapon routine 0x71, `sub_8012464`; Shadow's and Momogra's
-- charged shot): the navi turns invisible for 120 ticks (instant effect 2,
-- lib/instant/invisible), which the instant chips' action runs. In a link
-- battle the opponent's support Rush takes it first, as it takes the second
-- WhiCapsl (`sub_8010740` with chip 0x17E): then the navi stays idle.

local invisible = require("../instant/invisible")
local white_capsule_invisible = require("../../chips/white_capsule_invisible").white_capsule_invisible

-- The ticks (the attack's parameter, 0x78).
local TICKS = 0x78

-- `sub_8012464`.
local function setup(navi: Object): boolean?
    if navi:rush_cancels(white_capsule_invisible) then
        navi:exit_attack()
        return false
    end
    return nil
end

return new.weapon {
    id = "patch_cards/invisible_charge",
    -- The charge table's row 0x71, by Charge 0 to 7: past 4 it reads on
    -- into the next routine's row, as the original's table does.
    charge_ticks = { 170, 160, 150, 145, 140, 90, 80, 70 },
    setup = setup,
    instant = invisible.instant(TICKS),
}
