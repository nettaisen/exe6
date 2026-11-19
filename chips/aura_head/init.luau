--!strict
-- AuraHed1-3 and StreamHd: an aura head fired along the row (./action,
-- ./head); StreamHd fires five.

local action = require("@self/action")
local lockon = require("../rules/lockon")

-- Every head charges at 12 pixels a tick (`byte_80D74D4`).
local SPEED = 0xC_0000

local aura_head_1: Chip = {
    codes = { "B", "C", "D" },
    element = Element.null,
    family = Family["break"],
    class = ChipClass.standard,
    rarity = 0,
    mb = 25,
    damage = 130,
    counter = 30,
    lockout = 0,
    flags = { has_damage = true, standard_library = true, library = true },
    beast = { lockon = lockon.yo_yo },
    slot_in_limit = 3,
    traits = { aura_bonus = true },
    action = action.action {
        id = "aura_head_1/action",
        head = { palette = 0, speed = SPEED, strong = true, far = false },
    },
}

local aura_head_2: Chip = {
    codes = { "D", "E", "F" },
    element = Element.null,
    family = Family["break"],
    class = ChipClass.standard,
    rarity = 1,
    mb = 33,
    damage = 150,
    counter = 30,
    lockout = 0,
    flags = { has_damage = true, standard_library = true, library = true },
    beast = { lockon = lockon.yo_yo },
    slot_in_limit = 3,
    traits = { aura_bonus = true },
    action = action.action {
        id = "aura_head_2/action",
        head = { palette = 1, speed = SPEED, strong = true, far = false },
    },
}

local aura_head_3: Chip = {
    codes = { "F", "G", "H" },
    element = Element.null,
    family = Family["break"],
    class = ChipClass.standard,
    rarity = 2,
    mb = 39,
    damage = 170,
    counter = 30,
    lockout = 0,
    flags = { has_damage = true, standard_library = true, library = true },
    beast = { lockon = lockon.yo_yo },
    slot_in_limit = 3,
    traits = { aura_bonus = true },
    action = action.action {
        id = "aura_head_3/action",
        head = { palette = 2, speed = SPEED, strong = true, far = false },
    },
}

local stream_head: Chip = {
    codes = {},
    element = Element.null,
    family = Family.program_advance,
    class = ChipClass.program_advance,
    rarity = 0,
    mb = 5,
    damage = 150,
    counter = 5,
    lockout = 20,
    flags = { has_damage = true, library = true },
    beast = { lockon = lockon.cannon },
    slot_in_limit = 1,
    program_advances = {
        { order = 40, code_run = { chip = aura_head_1, count = 3 } },
        { order = 41, code_run = { chip = aura_head_2, count = 3 } },
        { order = 42, code_run = { chip = aura_head_3, count = 3 } },
    },
    traits = { aura_bonus = true },
    -- Five heads to the far edge, the last one strong.
    action = action.action {
        id = "stream_head/action",
        head = { palette = 0, speed = SPEED, strong = false, far = true },
        stream = true,
    },
}

return { aura_head_1 = aura_head_1, aura_head_2 = aura_head_2, aura_head_3 = aura_head_3, stream_head = stream_head }
