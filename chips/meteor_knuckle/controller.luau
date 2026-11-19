--!strict
-- MetrKnuk's dimming controller (the original's effect object #0x76,
-- `sub_80E8B00`; docs/engine/dimming-chip-effects.md §18): the shared
-- controller (@exelib/meteor_knuckle/controller), EXE6's kind: the usual dimming
-- phases, with an effect that throws 16 fists (./fist) at the enemy's
-- area, 8 ticks apart: the first at a random panel an enemy stands on, the
-- others at random panels around the enemies (never the last one twice in
-- a row), or of the enemy's area when no enemy stands.

local common = require("@exelib/meteor_knuckle/controller")
local fist = require("./fist")

return common.make {
    id = "meteor_knuckle/controller",
    fist = fist.spawn,
    first_on_body = true,
    area_fallback = true,
    fists_take_element = true,
}
