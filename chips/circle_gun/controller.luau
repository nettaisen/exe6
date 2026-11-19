--!strict
-- CircGun's dimming controller (the original's effect object #0x5E,
-- `sub_80E7568`): the shared controller (@exelib/circle_gun/controller), EXE6's
-- kind with EXE6's gun (./gun).

local common = require("@exelib/circle_gun/controller")
local gun = require("./gun")

local exe6 = common.make("circle_gun/controller", gun.kind)

return { hook = exe6.hook, variant = common.variant, make = common.make }
