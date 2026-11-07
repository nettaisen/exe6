--!strict
-- DarkThnd: Thunder's shot (chips/thunder) with a big ball that homes in
-- for 12 panels.

local shoot = require("./thunder/shoot")
local lockon = require("../rules/lockon")
local thunder = require("./thunder").thunder
local statuses = require("../rules/status")

-- Its hits' status: paralysis.
local PARALYZE = statuses.paralyze_90

local chip: Chip = {
    codes = { "A", "B", "C", "*" },
    element = Element.elec,
    family = Family.elec,
    class = "standard",
    rarity = 4,
    mb = 80,
    damage = 200,
    counter = 20,
    lockout = 0,
    flags = { has_damage = true },
    beast = { lockon = lockon.firebrn1 },
    slot_in_limit = 1,
    dark_substitute = thunder,
    hp_bug = 1,
    -- Its ball (12 panels, the original's DarkThnd's): big, with its own
    -- sound.
    action = shoot.action {
        id = "darkthnd/action",
        ball = { panels = 0x0C, status = PARALYZE, big = true, sound = asset.sound("elec-man") },
    },
}

return { darkthnd = chip }
