--!strict
-- Sensor1, Sensor2, Sensor3: cut-in chips that set a turret in front of
-- the user; it scans along its aim and, finding one of the other side's
-- bodies, fires a paralyzing laser down the line (controller.luau).

local controller = require("@self/controller")

local chips: { [string]: Chip } = {
    sensor1 = {
        codes = { "J", "O", "W" },
        element = Element.elec, family = Family.elec, class = "standard",
        rarity = 0, mb = 32, damage = 100, counter = 30, lockout = 0,
        flags = { dimming = true, has_damage = true, standard_library = true, library = true },
        slot_in_limit = 3,
        dimming = controller.hook { palette = 0, hp = 20 },
    },
    sensor2 = {
        codes = { "N", "U", "Y" },
        element = Element.elec, family = Family.elec, class = "standard",
        rarity = 1, mb = 35, damage = 130, counter = 30, lockout = 0,
        flags = { dimming = true, has_damage = true, standard_library = true, library = true },
        slot_in_limit = 3,
        dimming = controller.hook { palette = 3, hp = 30 },
    },
    sensor3 = {
        codes = { "I", "K", "Q" },
        element = Element.elec, family = Family.elec, class = "standard",
        rarity = 2, mb = 38, damage = 160, counter = 30, lockout = 0,
        flags = { dimming = true, has_damage = true, standard_library = true, library = true },
        slot_in_limit = 3,
        dimming = controller.hook { palette = 6, hp = 40 },
    },
}

return chips
