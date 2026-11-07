--!strict
-- Navi+20: folded into the navi chip before it on the custom screen, 20
-- more damage; used alone, a sparkle (or, from a special source, the
-- side's navi bonus).

local plus = require("../lib/instant/plus")

local chip: Chip = {
    codes = { "*" },
    element = Element.null, family = Family.plus, class = "standard",
    rarity = 2, mb = 36, damage = 20, counter = 0, lockout = 20,
    flags = { standard_library = true, library = true },
    extra_flags = { modifier = true },
    slot_in_limit = 1,
    modifier = "navi_plus",
    instant = plus.navi,
}

return { ["navi-20"] = chip }
