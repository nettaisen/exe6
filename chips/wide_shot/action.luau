--!strict
-- WideSht and SuprSpr (the original's action 0x30, `sub_80ED55C`;
-- docs/engine/shot-chips.md §10): the shared action
-- (@exelib/wide_shot/action) with EXE6's wide shooter, attachment and wave.
--
-- Each chip states its action with its own wave (WideSht's ./init,
-- SuprSpr's chips/super_spread).

local attachment = require("../../objects/attachment")
local common = require("@exelib/wide_shot/action")
local wave = require("./wave")
local wide_shooter_sprite = asset.sprite("wide_shooter")

local wide_shot = {}

wide_shot.STATE = common.STATE

local LOOK: WideShotLook = {
    -- The wide shooter (the original's attachment row 0x23).
    shooter = attachment.look { sprite = wide_shooter_sprite, palette = 0, attach_point = 12 },
    attachment = attachment.kind,
    wave = wave.kind,
}

function wide_shot.action(spec: WideShotSpec): Action
    return common.action(spec, LOOK)
end

-- A wave variant.
wide_shot.variant = wave.variant

return wide_shot
