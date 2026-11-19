--!strict
-- WideBrn1, WideBrn2 and WideBrn3 (FireBrn's Program Advances): the
-- burner's flame (lib/burner) on the panel ahead, burning 60 ticks and
-- spreading two panels forward on three rows, cracking the panels it
-- leaves. The three differ only in their damage.

local attachment = require("../objects/attachment")
local burn = require("../lib/burner/burn")
local firebrn_chips = require("./fire_burner")
local lockon = require("../rules/lockon")
local burner_sprite = asset.sprite("burner")

local function wide_burn(id: string): Action
    return burn.action {
        id = id,
        -- The burner (the original's attachment row 0x16).
        burner = attachment.look { sprite = burner_sprite, palette = 0, attach_point = 0x14 },
        flame = { ticks = 60, spread = 2, wide = true, cracks = true },
    }
end

local wide_burner_1: Chip = {
    codes = { "A", "B", "C", "*" },
    element = Element.fire,
    family = Family.program_advance,
    class = ChipClass.program_advance,
    rarity = 0,
    mb = 5,
    damage = 300,
    counter = 2,
    lockout = 0,
    flags = { has_damage = true, library = true },
    beast = { lockon = lockon.gun_del_sol_1 },
    slot_in_limit = 1,
    program_advances = { { order = 17, code_run = { chip = firebrn_chips.fire_burner_1, count = 3 } } },
    action = wide_burn("wide_burner_1/action"),
}

local wide_burner_2: Chip = {
    codes = { "A", "B", "C", "*" },
    element = Element.fire,
    family = Family.program_advance,
    class = ChipClass.program_advance,
    rarity = 0,
    mb = 5,
    damage = 350,
    counter = 2,
    lockout = 0,
    flags = { has_damage = true, library = true },
    beast = { lockon = lockon.gun_del_sol_1 },
    slot_in_limit = 1,
    program_advances = { { order = 18, code_run = { chip = firebrn_chips.fire_burner_2, count = 3 } } },
    action = wide_burn("wide_burner_2/action"),
}

local wide_burner_3: Chip = {
    codes = { "A", "B", "C", "*" },
    element = Element.fire,
    family = Family.program_advance,
    class = ChipClass.program_advance,
    rarity = 0,
    mb = 5,
    damage = 400,
    counter = 2,
    lockout = 0,
    flags = { has_damage = true, library = true },
    beast = { lockon = lockon.gun_del_sol_1 },
    slot_in_limit = 1,
    program_advances = { { order = 19, code_run = { chip = firebrn_chips.fire_burner_3, count = 3 } } },
    action = wide_burn("wide_burner_3/action"),
}

return { wide_burner_1 = wide_burner_1, wide_burner_2 = wide_burner_2, wide_burner_3 = wide_burner_3 }
