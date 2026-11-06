--!strict
-- The charged shot of the patch card puffy (`patch-cards/puffy/charge`):
-- a bubble spread. The original's weapon routine 0x5F (`sub_80123AA`) fires
-- the Spreaders' action (0x25, chips/spreadr) as SpoutCross's charged shot
-- does, from the water cannon, low, with the bullet's row 7: a splash over
-- the 3x3 around the panel it finds, 70 Aqua damage.

local attachment = require("../../objects/attachment")
local bullet = require("../../objects/bullet")
local regions = require("@exelib/regions")
local spreader = require("../../chips/spreadr/action")
local water_cannon_sprite = asset.sprite("water-cannon")

-- The Spreaders' action as the original's variant 2 (the water cannon,
-- fired from the ground) with the bubble's bullet (the parameter word 7).
-- (Its compat key maps it to 0x25.)
local SHOT = spreader.action {
    id = "patch-cards/puffy/charge/action",
    -- The water cannon, at the navi's attach point 25.
    gun = attachment.look { sprite = water_cannon_sprite, palette = 0, attach_point = 25 },
    z = 0,
    bullet = bullet.variant { region = regions.square, hit_mod = { flinch = true, flash = true }, effect = bullet.splash, sound = bullet.splash_sound },
}

-- The attack: 70 damage, hit parameter 0x0A, Aqua.
local DAMAGE, COUNTER, AQUA = 0x46, 10, Element.aqua
-- `sub_80123AA`.
local function setup(navi: Object): Action
    navi.attack_word = damage_word.of { amount = DAMAGE, counter = COUNTER }
    navi.attack_element = AQUA
    return SHOT
end

return new.weapon {
    id = "patch-cards/puffy/charge",
    -- The charge table's row 0x5F, by Charge 0 to 7: past 4 it reads on
    -- into the next routine's row, as the original's table does.
    charge_ticks = { 100, 90, 80, 75, 70, 120, 110, 100 },
    setup = setup,
}
