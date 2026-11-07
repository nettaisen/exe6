--!strict
-- SumnBlk1, SumnBlk2, SumnBlk3: cut-in chips that call a navi out of the
-- hole in front of the user; it comes up in front of one of the other
-- side's navis and claws its column (controller.luau). Without a free
-- hole in front, nothing happens.

local controller = require("@self/controller")
local lockon = require("../rules/lockon")

local chips: { [string]: Chip } = {
    sumnblk1 = {
        codes = { "E", "I", "P" },
        element = Element.null, family = Family.null, class = ChipClass.standard,
        rarity = 0, mb = 30, damage = 160, counter = 30, cant_counter = true, lockout = 0,
        flags = { dimming = true, has_damage = true, standard_library = true, library = true },
        slot_in_limit = 3,
        beast = { rush = false, lockon = lockon.cannon },
        dimming = controller.hook(0),
    },
    sumnblk2 = {
        codes = { "H", "O", "V" },
        element = Element.null, family = Family.null, class = ChipClass.standard,
        rarity = 1, mb = 40, damage = 200, counter = 30, cant_counter = true, lockout = 0,
        flags = { dimming = true, has_damage = true, standard_library = true, library = true },
        slot_in_limit = 3,
        beast = { rush = false, lockon = lockon.cannon },
        dimming = controller.hook(3),
    },
    sumnblk3 = {
        codes = { "W", "Y", "Z" },
        element = Element.null, family = Family.null, class = ChipClass.standard,
        rarity = 2, mb = 46, damage = 260, counter = 30, cant_counter = true, lockout = 0,
        flags = { dimming = true, has_damage = true, standard_library = true, library = true },
        slot_in_limit = 3,
        beast = { rush = false, lockon = lockon.cannon },
        dimming = controller.hook(6),
    },
}

return chips
