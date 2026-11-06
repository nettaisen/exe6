--!strict
-- LifeSync: a cut-in chip that, outside link battles, sets the HP of the
-- other side's combatants to that of the enemy two panels ahead; in a link
-- battle it only dims (docs/engine/dimming-chip-effects.md §14).

local controller = require("@self/controller")
local lockon = require("../rules/lockon")

local chip: Chip = {
    codes = { "*" },
    element = "null", family = "cursor", class = "standard",
    rarity = 1, mb = 12, damage = 0, counter = 0, lockout = 0,
    flags = { dimming = true, standard_library = true, library = true },
    extra_flags = { free_slot_in = true },
    beast = { lockon = lockon.firebrn1 },
    slot_in_limit = 3,
    dimming = controller.hook,
}

return { lifesync = chip }
