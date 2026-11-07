--!strict
-- Atk+10: folded into the chip before it on the custom screen, 10 more
-- damage; used alone, a sparkle (or, from a special source, the side's
-- attack bonus).

local plus = require("../lib/instant/plus")

local chip: Chip = {
    codes = { "*" },
    element = Element.null, family = Family.plus, class = "standard",
    rarity = 0, mb = 4, damage = 10, counter = 0, lockout = 20,
    flags = { standard_library = true, library = true },
    extra_flags = { modifier = true, free_slot_in = true },
    slot_in_limit = 1,
    modifier = "attack_plus",
    instant = plus.attack,
}

return { ["atk-10"] = chip }
