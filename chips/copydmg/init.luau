--!strict
-- CopyDmg (the original's action 0x23, `sub_80ECA34`): the action EXE5
-- shares (@exelib/copydmg/action): the navi raises its buster and, on the
-- next tick, fires its mark (mark.luau) along its row from the panel
-- ahead: the first navi it hits takes, for 180 ticks, the damage its side
-- took the tick before on top of its own. 5 ticks, then 11 of recovery.

local action = require("@exelib/copydmg/action")
local buster = require("../lib/buster")
local lockon = require("../rules/lockon")
local mark = require("@self/mark")

local chip: Chip = {
    codes = { "*" },
    element = Element.null, family = Family.cursor, class = ChipClass.standard,
    rarity = 1, mb = 12, damage = 0, counter = 0, lockout = 0,
    flags = { standard_library = true, library = true },
    extra_flags = { free_slot_in = true },
    slot_in_limit = 3,
    -- The Beast rush, and its lock-on mode (rules/lockon).
    beast = { lockon = lockon.cannon },
    action = action.make {
        id = nil,
        sound = asset.sound("buster-shot"),
        raise_arm = buster.raise_arm,
        shot = mark.spawn,
    },
}

return { copydmg = chip }
