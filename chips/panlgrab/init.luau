--!strict
-- PanlGrab: a dimming that drops a grab shot on the first panel past the
-- user's side's front in its row, taking the panel if it can.

local grab = require("../lib/grab/controller")

local chip: Chip = {
    codes = { "*" },
    element = Element.null, family = Family.null, class = ChipClass.standard,
    rarity = 0, mb = 6, damage = 10, counter = 10, cant_counter = true, lockout = 0,
    flags = { dimming = true, standard_library = true, library = true },
    slot_in_limit = 1,
    dimming = grab.panel,
}

return { panlgrab = chip }
