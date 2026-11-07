--!strict
-- AirHocky: a puck flicked from the panel ahead, slanting down the field,
-- that bounces around for 10 steps (flick.luau).

local flick = require("@self/flick")
local puck = require("@self/puck")
local lockon = require("../rules/lockon")

-- The puck (`byte_80C9818`'s row 2): 10 steps.
local PUCK = puck.variant { steps = 0x0A, own_side = 1, ticks = 6 }

local chip: Chip = {
    codes = { "L", "M", "N" },
    element = Element.null,
    family = Family["break"],
    class = "standard",
    rarity = 2,
    mb = 19,
    damage = 60,
    counter = 5,
    lockout = 50,
    flags = { has_damage = true, standard_library = true, library = true },
    beast = { lockon = lockon.thunder },
    slot_in_limit = 3,
    action = flick.action { id = "airhocky/action", puck = PUCK, down = true },
}

return { airhocky = chip }
