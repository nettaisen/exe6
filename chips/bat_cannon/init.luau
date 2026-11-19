--!strict
-- BatCan1-4: the navi raises its bat cannon and fires an unseen shot
-- (shot.luau) from the panel ahead on the 7th tick; BatCan4 fires three,
-- 16 ticks apart, the last staggering harder (the original's action 0x19,
-- `sub_80EC0E6`; docs/engine/shot-chips.md §6). The behavior is EXE5's too
-- (@exelib/bat_cannon, made in shot.luau with EXE6's look).

local lockon = require("../rules/lockon")
local shot = require("@self/shot")

-- A chip's action, for its shots: each one's hit modifier, in the order
-- they're fired (the original's chip parameters, or BatCan4's
-- `byte_80EC1BC`).
local bat_cannon = shot.action

local chips: { [string]: Chip } = {
    bat_cannon_1 = {
        codes = { "*" },
        element = Element.null, family = Family.null, class = ChipClass.standard,
        rarity = 0, mb = 5, damage = 40, counter = 30, lockout = 0,
        flags = { has_damage = true },
        slot_in_limit = 1,
        -- The Beast rush, and its lock-on mode (rules/lockon).
        beast = { lockon = lockon.cannon },
        action = bat_cannon { shots = { { flinch = true, flash = true } } },
    },
    bat_cannon_2 = {
        codes = { "S" },
        element = Element.null, family = Family.null, class = ChipClass.standard,
        rarity = 0, mb = 5, damage = 40, counter = 30, lockout = 0,
        flags = { has_damage = true },
        slot_in_limit = 1,
        -- The Beast rush, and its lock-on mode (rules/lockon).
        beast = { lockon = lockon.cannon },
        action = bat_cannon { shots = { { flinch = true, flash = true } } },
    },
    bat_cannon_3 = {
        codes = { "R" },
        element = Element.null, family = Family.null, class = ChipClass.standard,
        rarity = 0, mb = 5, damage = 40, counter = 30, lockout = 0,
        flags = { has_damage = true },
        slot_in_limit = 1,
        -- The Beast rush, and its lock-on mode (rules/lockon).
        beast = { lockon = lockon.cannon },
        action = bat_cannon { shots = { { flinch = true, flash = true } } },
    },
    bat_cannon_4 = {
        codes = { "Z" },
        element = Element.null, family = Family.null, class = ChipClass.standard,
        rarity = 0, mb = 5, damage = 40, counter = 30, lockout = 0,
        flags = { has_damage = true },
        slot_in_limit = 1,
        -- The Beast rush, and its lock-on mode (rules/lockon).
        beast = { lockon = lockon.cannon },
        action = bat_cannon { shots = { { flinch = true }, { flinch = true }, { flinch = true, flash = true } } },
    },
}

return chips
