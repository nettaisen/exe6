--!strict
-- BlzrdBal's snowball (the original's attack object #0xB2, `sub_80DB994`;
-- docs/engine/dimming-chip-effects.md §10): the shared snowball
-- (@exelib/blizzard_ball/ball), EXE6's kind and look. It rolls 3 pixels a tick to
-- the end of the field, hitting once in each column it enters, and stops on
-- a panel that isn't solid. Its roller (./roller), a step ahead, swallows
-- the field objects it meets: each makes the ball bigger (its animation 1)
-- and its hits harder by the chip's damage (its low 12 bits), with a sound.

local collision = require("../../rules/collision")
local common = require("@exelib/blizzard_ball/ball")
local roller = require("./roller")
local blizzard_ball_sprite = asset.sprite("blizzard_ball")

local ball = {}

ball.kind = common.make_kind {
    id = "blizzard_ball/ball",
    sprite = blizzard_ball_sprite,
    anim = 0,
    grown = { 1, 1 },
    roller = roller.kind,
    self_type = collision.attack,
    target = collision.hits_navis,
    growth = "damage",
    grow_sound = asset.sound("blizzard_grow"),
}

-- `sub_80DBB0C`: a ball at (x, y) on the ground with `element` and the
-- damage word, of `owner`'s side and facing, running while dimmed.
function ball.spawn(owner: Object, x: number, y: number, element: Element, damage: number): Object?
    return common.spawn(ball.kind, owner, x, y, element, damage)
end

return ball
