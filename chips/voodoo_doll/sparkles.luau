--!strict
-- Sparkles (the original's effect object #0x11, `sub_80E19BC`): the shared ones (@exelib/voodoo_doll/sparkles) of EXE6's
-- kind and sound. VDoll's curse (./curse) marks the combatants it hits with them. See docs/engine/shot-chips.md §14.2.

local common = require("@exelib/voodoo_doll/sparkles")

return common.make { id = "voodoo_doll/sparkles", sound = asset.sound("hit_bomb_0") }
