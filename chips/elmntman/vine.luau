--!strict
-- ElmntMan's vine (the original's attack object #0xB9, `sub_80DC4FC`): a
-- vine shooting up
-- from its panel (his own sprite's animation 0x12), hitting it once (a
-- hit region that runs while dimmed), and showing for 30 ticks. His Wood
-- grows them along his row, a panel at a time. It runs while dimmed. See
-- docs/engine/chips.md §3.6.7.

local collision = require("../../rules/collision")
local regions = require("@exelib/regions")
local sparks = require("../../lib/sparks")

local vine = {}

local SPRITE = asset.sprite("elmnt-man")
local SOUND_ELMNT_VINE = asset.sound("elmnt-vine")
local ANIM = 0x12

-- `sub_80DC520`: on its panel, on the ground (Z's whole part cleared).
local function init(me: Object)
    me:set_coordinates_from_panel()
    local p = me.pos
    me.pos = Vec3.new(p.x, p.y, bit32.band(p.z, 0xFFFF))
    local sprite = me.sprite
    sprite:load(SPRITE)
    sprite.shadow = Shadow.with_sprite
    me.visible = true
    me.anim = ANIM
    me.anim_loaded = ANIM
    sprite:set_animation(ANIM)
    sprite.palette = 0
    sprite:face(me)
    me:enter_update()
end

-- `sub_80DC5DA`: the hit, running while dimmed (`sub_80C53A6`).
local function hit(me: Object)
    local box = battle.hitbox(me, {
        panel_x = me.panel_x,
        panel_y = me.panel_y,
        element = me.element,
        z = 0,
        region = regions.single,
        hit_effect = sparks.wood,
        target = collision.hits_navis,
        self_type = collision.thrown,
        damage = me.damage_word,
        hit_mod = { flinch = true },
    })
    if box then
        box.run_while_dimmed = true
    end
end

-- `sub_80DC588`: grow, then show for 30 ticks.
local function grow(me: Object)
    if me.phase == 0 then
        me.phase = 4
        hit(me)
        battle.play_sound(SOUND_ELMNT_VINE)
        me.timer = 0x1E
        return
    end
    local left = me.timer - 1
    me.timer = left
    if left <= 0 then
        me:enter_destroy()
    end
end

-- `loc_80DC562`: gone once the battle is over.
local function tick(me: Object)
    if battle.over() then
        me:enter_destroy()
        return
    end
    if me.action ~= 0 then
        error(string.format("ElmntMan's vine action %#x reads past its table (off_80DC584)", me.action))
    end
    grow(me)
end

vine.kind = new.kind {
    id = "elmntman/vine",
    pool = Pool.attack,
    -- `sub_80DC4FC`.
    update = function(me: Object)
        local l = me.lifecycle
        if l == Lifecycle.init then
            init(me)
        elseif l == Lifecycle.update then
            tick(me)
        else
            me:destroy()
        end
        me:update_sprite_while_dimmed()
    end,
}

-- `sub_80DC5B4`: a vine on (x, y) with `element` and the damage word; `z`
-- is the spawner's register (the row it checked minus 1), which becomes
-- its Z, of which it keeps the fraction.
function vine.spawn(owner: Object, x: number, y: number, element: Element, damage: number, z: number): Object?
    local o = battle.spawn(vine.kind, Vec3.new(y, element.byte, z))
    if o then
        o.panel_x, o.panel_y = x, y
        o.element = element
        o.damage_word = damage
        o.alliance, o.flip = owner.alliance, owner.flip
        o.run_while_dimmed = true
    end
    return o
end

return vine
