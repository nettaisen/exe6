--!strict
-- RockCube and IceCube: a dimming that sets a rock on the panel in front of
-- the user, rising out of it: RockCube's a rock cube with 200 HP, IceCube's
-- an ice block (docs/engine/field-objects.md §3).

local cube = require("@self/cube")
local rock = require("@self/rock")

local rockcube: Chip = {
    codes = { "*" },
    element = "null",
    family = "summon",
    class = ChipClass.standard,
    rarity = 0,
    mb = 6,
    damage = 200,
    counter = 30,
    cant_counter = true,
    lockout = 0,
    flags = { dimming = true, standard_library = true, library = true },
    extra_flags = { free_slot_in = true },
    slot_in_limit = 3,
    dimming = cube.places { variant = rock.variants.cube },
}

local icecube: Chip = {
    codes = { "A", "B", "C", "*" },
    element = "null",
    family = "summon",
    class = ChipClass.special,
    rarity = 0,
    mb = 5,
    damage = 200,
    counter = 0,
    lockout = 0,
    slot_in_limit = 1,
    -- (The other side can't cut in on its dimming.)
    traits = { no_cut_in = true },
    dimming = cube.places { variant = rock.variants.ice },
}

return { rockcube = rockcube, icecube = icecube }
