--!strict
-- Falzar's charged shot of the patch card bass-cross-megaman
-- (`patch-cards/bass-cross-megaman/charge`): AirSpin's action with its
-- variant 1, which no chip has: a seeking whirlwind (chips/airspin/whirl).
-- The original's weapon routine 0x93 is `sub_8012144`, routine 0x3A's, with
-- its own charge row: (Attack + 1) * 10 damage, hit parameter 0x94, Null.

local airspin = require("../../chips/airspin/action")
local whirl = require("../../chips/airspin/whirl")

-- AirSpin's action sending the seeking whirlwind. (Its compat key maps it
-- to 0x38.)
local SPIN = airspin.action {
    id = "patch-cards/bass-cross-megaman/charge/action",
    whirlwind = whirl.sender,
}

local COUNTER = 20
-- `sub_8012144`.
local function setup(navi: Object): Action
    navi.attack_word = damage_word.of { amount = (battle.navi(navi.alliance).attack + 1) * 10, counter = COUNTER, cant_counter = true }
    navi.attack_element = Element.null
    navi.extra = 0
    return SPIN
end

return new.weapon {
    id = "patch-cards/bass-cross-megaman/charge",
    -- The charge table's row 0x93, by Charge 0 to 7: past 4 it reads on
    -- into the bytes after the table (Charge stays below 5 with the cards).
    charge_ticks = { 140, 130, 120, 110, 100, 2052, 4108, 6164 },
    setup = setup,
}
