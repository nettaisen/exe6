--!strict
-- GrabBnsh's and GrabRvng's hand (the original's attack object #0x46,
-- `sub_80CCC48`): the shared hand (@exelib/grab_banish/hand), EXE6's kind and
-- look: its hit an attack that pierces invisibility (row 0x19), hitting
-- navis.

local collision = require("../../rules/collision")
local common = require("@exelib/grab_banish/hand")
local grab_shot_sprite = asset.sprite("grab_shot")

local hand = {}

hand.kind = common.make_kind {
    id = "grab_banish/hand",
    sprite = grab_shot_sprite,
    fall_sound = asset.sound("grab_shot_2"),
    land_sound = asset.sound("grab_shot"),
    grab_steps = 16,
    target = collision.hits_navis,
    self_type = collision.curse,
}

return hand
