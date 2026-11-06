--!strict
-- What EXE6's buster shots share (the buster, the charged shot, the blank
-- shot, DustCross's charged shot and the like; @exelib/buster): the arm the
-- navi raises, the recovery after a shot, and the move that may cut the
-- recovery short. See docs/engine/objects-and-player.md §B6.

local attachment = require("../objects/attachment")
local common = require("@exelib/buster")
local buster_arm_sprite = asset.sprite("buster-arm")
local elec_coil_sprite = asset.sprite("elec-coil")
local muzzle_flash_sprite = asset.sprite("muzzle-flash")

return common.make {
    -- The muzzle flash a shot leaves in the navi's first related slot (the
    -- original's attachment row 5, at attach point 0x10), and the buster
    -- arm (row 6), which `raise_arm` raises and a thrown obstacle leaves
    -- there instead.
    flash = attachment.look { sprite = muzzle_flash_sprite, palette = 0, attach_point = 0x10 },
    arm = attachment.look { sprite = buster_arm_sprite, palette = 0 },
    -- An enemy navi's arm (the original's attachment row 0x2B, at attach
    -- point 0x0E).
    navi_arm = attachment.look { sprite = elec_coil_sprite, palette = 0, attach_point = 0x0E },
    -- The buster's recovery in ticks (`byte_80209CC`), by Rapid, then the
    -- open panels ahead.
    recovery = require("../rules/buster").recovery,
    -- What stops a shot's panel count (`byte_800FB4C`, by side): bodies,
    -- neutral objects, blockers and reservations, but its own side's other
    -- bodies.
    closed = { "reserved", "own_body", "enemy_body", "enemy_other_body", "neutral", "blocker" },
    attachment = attachment.kind,
}
