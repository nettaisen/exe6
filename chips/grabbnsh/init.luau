--!strict
-- GrabBnsh and GrabRvng: the user's side takes back the panels the other
-- side stole, and for each, a hand drops on every enemy navi's panel
-- (docs/engine/dimming-chip-effects.md §3).

local controller = require("@self/controller")

local grabbnsh: Chip = {
    codes = { "B", "M", "S" },
    element = "null",
    family = "null",
    class = "standard",
    rarity = 2,
    mb = 24,
    damage = 20,
    counter = 10,
    cant_counter = true,
    lockout = 0,
    flags = { dimming = true, standard_library = true, library = true },
    slot_in_limit = 1,
    dimming = controller.hook,
}

local grabrvng: Chip = {
    codes = { "I", "Q", "Z" },
    element = "null",
    family = "null",
    class = "standard",
    rarity = 3,
    mb = 50,
    damage = 40,
    counter = 10,
    cant_counter = true,
    lockout = 0,
    flags = { dimming = true, standard_library = true, library = true },
    slot_in_limit = 1,
    dimming = controller.hook,
}

return { grabbnsh = grabbnsh, grabrvng = grabrvng }
