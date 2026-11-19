--!strict
-- A seeking whirlwind (attack object #0xD4, `sub_80DFFB8`): the shared seeking whirlwind (@exelib/air_spin/whirl,
-- EXE5's too) in EXE6's look: what AirSpin's variant 1 sends (no chip in the table does: `whirl.sender`; the patch card
-- bass-cross-megaman's charged shot). An enemy navi invisible or submerged it doesn't see.

local collision = require("../../rules/collision")
local common = require("@exelib/air_spin/whirl")
local bass_anly_shot_sprite = asset.sprite("bass_anly_shot")

return common.make {
    id = "air_spin/whirl",
    sprite = bass_anly_shot_sprite,
    sound = asset.sound("bass_anly_shot"),
    attack = collision.attack,
    hits = collision.hits_navis,
    hidden = { invisible = true, submerged = true },
}
