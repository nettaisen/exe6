--!strict
-- Roll's heart (the original's attack object #0x4E, `sub_80CE118`): EXE6's
-- (@exelib/roll/heart, which EXE5's shares). It sinks from 160 pixels above
-- her user's panel, 3 pixels a tick, sparkling every 10 ticks; landed, it
-- heals the user by its damage (or to full, with none), with a sound and
-- an effect, and goes 60 ticks later. See docs/engine/chips.md §3.6.20.

local common = require("@exelib/roll/heart")
local elmnt_ice_sprite = require("../../sprites/elmnt_ice")
local heal_sprite = require("../../sprites/heal")
local roll_heart_sprite = require("./roll_heart_sprite")

-- The sparkle around it, and around Roll as she warps (effect 0x26), and
-- the effect on the healed navi (effect 0x06).
local SPARKLE = new.effect { sprite = elmnt_ice_sprite, anim = 0, palette = 0 }

local heart = common.make {
    id = "roll/heart",
    sprite = roll_heart_sprite,
    anim = 4,
    heal_sound = asset.sound("heal"),
    sparkle = SPARKLE,
    healed = new.effect { sprite = heal_sprite, anim = 0, palette = 0 },
}

return { kind = heart.kind, spawn = heart.spawn, sparkle = SPARKLE }
