--!strict
-- A point of ColorPt's and DblPoint's (the original's effect object #0x51,
-- `sub_80E655C`; docs/engine/dimming-chips.md §10.2): it gives its panel
-- to the other side (the stolen-area return brings it back), rises, and
-- flies to its side's navi; there the chip at the hand's cursor, if it does
-- damage, gets its bonus (or, while a special chip is in use, the side's
-- special bonus does). It tells its controller (the holder) when it is
-- gone. The behavior is EXE5's too (@exelib/color_point/point), made here with
-- EXE6's look.

local common = require("@exelib/color_point/point")
local trajectory = require("../../lib/trajectory")
local grab_shot_sprite = asset.sprite("grab_shot")

return common.make {
    id = "color_point/point",
    sprite = grab_shot_sprite,
    sounds = {
        appear = asset.sound("point_appear"),
        rise = asset.sound("point_rise"),
        arrive = asset.sound("cross_merge"),
    },
    -- While a special chip is in use (the player's AI+0xBB).
    special = function(_side: number, navi: Object): boolean
        return navi.special_source ~= 0
    end,
    trajectory = trajectory,
}
