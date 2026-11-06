--!strict
-- A gust (attack object #0x49, `sub_80CD2EC`): the shared gust (@exelib/gust/gust, EXE5's too) of EXE6's look: a wind
-- that blows along its row 10 pixels a tick, pushing what it hits, until it leaves the field, reaches a panel it
-- can't cross, is hit by a wind stopper, or (as some spawners ask) hits anything. WindRack blows unseen ones down
-- each row; Wind and Fan blow one row at a time; TenguCross's B+Back blows three (instant chip effect 0x14).
--
-- How it blows (`GustHow`, the original's first parameter): `pulls` (bit 0) turns it back toward its side, a weaker
-- push (hit modifier 4 rather than 8) in its other palette; `unseen` (bit 7) hides it and lets it blow through any
-- panel.

local collision = require("../rules/collision")
local common = require("@exelib/gust")
local gust_sprite = asset.sprite("gust")

local gust = {}

gust.kind = common.make_kind("gust", {
    sprite = gust_sprite,
    is = collision.pull,
    hits = collision.hits_navis,
    -- A hit that stops it: a neutral object's.
    stopped_by = "neutral",
    weak_when_unseen = false,
    -- The panels it can blow over (`byte_80CD478`, by side: the other side's area; its third row, read for a side of
    -- 2, is code: require 0xB427B500, forbid 0xF7352049).
    panels = { require = "enemy_area" },
})

-- `sub_80CD488`: a gust on (x, y) for side `alliance`, turned or not (`flip`)
-- (the spawner's halfword), blowing as `how` says, with the damage word
-- `damage`, and the spawner that tracks it by `holder.state.gusts[slot]`
-- (which becomes 1), if any.
function gust.spawn(
    x: number,
    y: number,
    alliance: number,
    flip: boolean,
    how: GustHow,
    damage: number,
    holder: Object?,
    slot: number
): Object?
    return common.spawn(gust.kind, x, y, alliance, flip, how, damage, holder, slot)
end

return gust
