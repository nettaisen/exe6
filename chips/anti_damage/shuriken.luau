--!strict
-- AntiDmg's shuriken (the original's attack object #0xC2, `sub_80DD764`):
-- the shared shuriken (@exelib/anti_damage/shuriken), EXE6's kind and look: a
-- thrown slash (row 0x1C) that hits navis.

local collision = require("../../rules/collision")
local common = require("@exelib/anti_damage/shuriken")
local effects = require("../../lib/effects")
local shuriken_sprite = asset.sprite("shuriken")

local shuriken = {}

shuriken.kind = common.make_kind {
    id = "anti_damage/shuriken",
    sprite = shuriken_sprite,
    land_sound = asset.sound("panel_crack"),
    puff = effects.bubbles,
    self_type = collision.thrown_slash,
    target = collision.hits_navis,
}

return shuriken
