--!strict
-- EnergBom and MegEnBom: a bomb that doesn't blast, but leaves an energy
-- burst where it lands (burst.luau): three hits on that panel.

local bomb = require("../lib/bombs/bomb")
local burst = require("@self/burst")
local collision = require("../rules/collision")
local lockon = require("../rules/lockon")
local throw = require("../lib/bombs/throw")

-- The two chips' throw: the same bomb, held in its second animation.
local function energy_throw(): Action
    return throw.action {
        held = bomb.held,
        held_anim = 2,
        thrower = bomb.thrower(bomb.variant {
            collision = { is = collision.thrown, hits = collision.hits_navis },
            hit_mod = { flinch = true },
            palette = 0,
            anim = 3,
            after = burst.leave,
        }),
    }
end

local chips: { [string]: Chip } = {
    energbom = {
        codes = { "C", "K", "V", "*" },
        element = Element.null, family = Family.null, class = "standard",
        rarity = 1, mb = 11, damage = 40, counter = 10, lockout = 0,
        flags = { has_damage = true, standard_library = true, library = true },
        slot_in_limit = 3,
        -- The Beast rush, and its lock-on mode (rules/lockon).
        beast = { lockon = lockon.yoyo },
        action = energy_throw(),
    },
    megenbom = {
        codes = { "G", "M", "O", "*" },
        element = Element.null, family = Family.null, class = "standard",
        rarity = 2, mb = 27, damage = 60, counter = 10, lockout = 0,
        flags = { has_damage = true, standard_library = true, library = true },
        slot_in_limit = 3,
        -- The Beast rush, and its lock-on mode (rules/lockon).
        beast = { lockon = lockon.yoyo },
        action = energy_throw(),
    },
}

return chips
