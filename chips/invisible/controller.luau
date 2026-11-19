--!strict
-- Invisibl's dimming controller (the original's effect object #0x5D,
-- `sub_80E74D4`), which the second WhiCapsl (chips/white_capsule_invisible)
-- uses too: the shared controller (@exelib/invisible/controller), EXE6's kind
-- and sound. A chip's `dimming` hook is `invisible.hook(ticks)`.

local common = require("@exelib/invisible/controller")

return common.make { id = "invisible/controller", sound = asset.sound("invisible") }
