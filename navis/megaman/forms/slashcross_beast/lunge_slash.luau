--!strict
-- SlashCross Beast's lunge's slash (the original's attack object #0xB1,
-- `sub_80DB8CC`): a hit on its panel and the four diagonal to it that
-- resolves as soon as it is placed. A body it strikes gets the hit's
-- flashes (./hit_flash). It keeps going while its timer lasts, which
-- nothing sets, so it ends at once.

local collision = require("../../../../rules/collision")
local hit_flash = require("./hit_flash")
local regions = require("@exelib/regions")

local lunge_slash = {}

-- What its hit struck that flashes: a body of either side.
local BODY: HitNames = { own_body = true, enemy_body = true }

-- Its hit: a slash at navis, no spark.
local HIT_MOD: HitModifier = { flinch = true, flash = true }

-- Done: its region, its collision, and the slot go.
local function finish(me: Object)
    local c = me.collision
    c:set_region(nil)
    c:free()
    me:free()
end

-- `sub_80DB934`: resolve the hit; flashes for a body it struck.
local function tick(me: Object)
    local c = me.collision
    c:remove()
    me:hit_spark()
    if c.hit then
        if c:hit_any(BODY) then
            hit_flash.spawn(me)
        end
        return finish(me)
    end
    local left = me.timer - 1
    me.timer = left
    if left <= 0 then
        return finish(me)
    end
    c:present()
end

-- `sub_80DB8EC`: on its panel (if it is on the field), with its hit.
local function init(me: Object)
    if not field.valid(me.panel_x, me.panel_y) then
        me:free()
        return
    end
    local x, y = field.center(me.panel_x, me.panel_y)
    me.pos = Vec3.new(x, y, me.pos.z)
    if not me:create_collision() then
        me:free()
        return
    end
    me:setup_collision(collision.slash, collision.hits_navis, HIT_MOD)
    local c = me.collision
    c:set_region(regions.x)
    c:set_hit_effect(nil)
    c:present()
    me:enter_update()
    tick(me)
end

lunge_slash.kind = new.kind {
    id = "slashcross-beast/lunge-slash",
    pool = Pool.attack,
    -- `sub_80DB8CC`.
    update = function(me: Object)
        local l = me.lifecycle
        if l == Lifecycle.init then
            init(me)
        elseif l == Lifecycle.update then
            tick(me)
        else
            me:destroy()
        end
    end,
}

-- `sub_80DB970`: a slash for `owner` on (x, y) with `element` and the
-- damage word `damage`. (Its position is the spawner's registers, Y, the
-- element and 0, until its init places it.)
function lunge_slash.spawn(owner: Object, x: number, y: number, element: Element, damage: number): Object?
    local o = battle.spawn(lunge_slash.kind, Vec3.new(y, element.byte, 0))
    if o then
        o.panel_x, o.panel_y = x, y
        o.element = element
        o.damage_word = damage
        o.alliance, o.flip = owner.alliance, owner.flip
    end
    return o
end

return lunge_slash
