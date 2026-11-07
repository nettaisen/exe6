--!strict
-- Invisibl: its user turns invisible for six seconds (its controller,
-- ./controller).

local invisible = require("@self/controller")

-- 360 ticks (the record's first two parameter bytes, 104 and 1).
local chip: Chip = {
    codes = { "*" },
    element = Element.null,
    family = Family.null,
    class = ChipClass.standard,
    rarity = 2,
    mb = 30,
    damage = 0,
    counter = 0,
    lockout = 0,
    flags = { dimming = true, standard_library = true, library = true },
    extra_flags = { rush_cancels = true, free_slot_in = true },
    slot_in_limit = 3,
    dimming = invisible.hook(360),
}

return { invisibl = chip }
