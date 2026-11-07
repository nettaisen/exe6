--!strict
-- BusterUp: the buster's attack level up by one (instant chip effect 10,
-- `sub_8010820`, run once by action 0x1C), with a sparkle at the navi's
-- attach point 0x20.

local buster_up_sprite = asset.sprite("buster-up")

local SPARKLE = new.effect { sprite = buster_up_sprite, anim = 0, palette = 0, steps = 17 }
local SOUND = asset.sound("hub")

-- Where the sparkle shows.
local ATTACH_POINT = 0x20

-- `sub_8010820`: the buster's attack level up by `by` (to 9 at most once
-- it reaches 10).
local function raise(by: number): (user: Object, spec: InstantChipSpec) -> ()
    return function(user: Object, _spec: InstantChipSpec)
        local stats = battle.navi(user.alliance)
        local level = stats.attack + by
        if level >= 10 then
            level = 9
        end
        stats.attack = level
        -- sub_8018810
        local dx, dz = user:attach_point(ATTACH_POINT)
        local p = user.pos
        battle.effect(Vec3.new(p.x + int.shl(dx, 16), p.y, p.z + int.shl(dz, 16)), SPARKLE)
        battle.play_sound(SOUND)
    end
end

local chip: Chip = {
    codes = { "*" },
    element = Element.null, family = Family.plus, class = ChipClass.standard,
    rarity = 1, mb = 11, damage = 0, counter = 0, lockout = 20,
    flags = { standard_library = true, library = true },
    slot_in_limit = 3,
    instant = raise(1),
}

return { busterup = chip }
