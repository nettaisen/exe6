--!strict
-- WindRack: a swing of a rack that hits the column ahead and blows unseen
-- gusts down every row from it (./action).

local attachment = require("../objects/attachment")
local action = require("@self/action")
local lockon = require("../rules/lockon")
local wind_rack_sprite = asset.sprite("wind-rack")

local chip: Chip = {
    codes = { "F", "J", "R", "*" },
    element = "null", family = "wind", class = "standard",
    rarity = 2, mb = 19, damage = 140, counter = 30, lockout = 0,
    flags = { has_damage = true, standard_library = true, library = true },
    slot_in_limit = 3,
    -- The Beast rush, and its lock-on mode (rules/lockon).
    beast = { lockon = lockon.widesht },
    -- Its rack (the original's attachment row 0x2A, variant 0).
    action = action.action { rack = attachment.look { sprite = wind_rack_sprite, palette = 0 } },
}

return { windrack = chip }
