--!strict
-- The rising bubble (the original's effect object #0x14, `sub_80E1CF8`):
-- the shared bubble (@exelib/rising_bubble/rising_bubble), EXE6's kind and
-- sprite (the small puff).

local common = require("@exelib/rising_bubble")
local small_puff_sprite = require("../sprites/small_puff")

local rising_bubble = {}

rising_bubble.kind = common.make_kind("rising-bubble", small_puff_sprite)

-- `sub_80E1D7A`: a bubble at `pos` in sprite palette `palette`.
function rising_bubble.spawn(pos: Vec3, palette: number): Object?
    return common.spawn(rising_bubble.kind, pos, palette)
end

return rising_bubble
