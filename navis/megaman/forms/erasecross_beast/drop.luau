--!strict
-- EraseCross Beast's charged Null chip (`erasecross-beast/drop`): the
-- original's weapon routine 0x15 (`sub_8011D20`) and action 0x46
-- (`sub_80EE840`). The navi raises its arms; when the animation ends, a
-- drop (./erase_drop) falls on the nearest enemy ahead (the first column
-- with one; its row, or the nearest row with one), or three panels ahead
-- if there is none; 21 ticks later it idles.

local erase_drop = require("./erase_drop")
local weapon = require("../../../../lib/weapon")

export type State = {
    -- AIAttackVars+0x10: ticks of recovery.
    timer: number,
}

local drop_weapon = {}

-- The phases, on the attack's step.
local RAISE, DROP, RECOVER = 0x0, 0x4, 0x8

-- Cursor (secondary element 0x40), the hit's counter byte.
local CURSOR, HIT_PARAM = 0x40, 0x9E

local SOUND = asset.sound("justice-one")

-- The navi raises its arms over 3 of its sprite's steps, and drops over
-- 8 (EraseCross Beast's raising and dropping animations' lengths).
local RAISE_STEPS, DROP_STEPS = 3, 8

-- What marks a panel with an enemy on it, of the navi's side, alone and
-- with the flag the column search wants too (`byte_80ED080`: every panel on
-- the field has it).
local ENEMY: PanelFlags = { enemy_body = true }
local ENEMY_COLUMN: PanelCondition = { enemy_body = true, on_field = true }

-- The rows tried in the enemy's column, as steps from the navi's row
-- (`byte_80EE904`): its own, above, below, two above, two below.
local ROW_STEPS = { 0, -1, 2, -3, 4 }

-- The drop's fall, in ticks.
local FALL_TICKS = 3

-- `sub_8011D20`: 70 damage and 30 more per point of buster Attack (up to
-- 5), Cursor.
local function setup(navi: Object): Action
    navi.attack_damage = weapon.charge_damage(navi, 0x46, 0x1E)
    navi.hit_param = HIT_PARAM
    navi.attack_element = CURSOR
    return drop_weapon.action
end

-- `sub_80ED040`: the first column ahead with an enemy on it; else the
-- far column, and false.
local function enemy_column(me: Object): (number, boolean)
    local front = me.facing
    local x = me.panel_x
    while true do
        x += front
        if x == 0 or x >= 7 then
            break
        end
        -- object_getPanelsInColumnFiltered
        for y = 1, 3 do
            if field.check(x, y, ENEMY_COLUMN, me.alliance) then
                return x, true
            end
        end
    end
    return if front > 0 then 6 else 1, false
end

-- `sub_80EE860`: raise the arms; when the animation ends, the drop's.
local function raise(me: Object)
    if me.step_init == 0 then
        me:set_animation(0x12)
        me:open_counter_window()
        me.status.using_action = true
        me.status.moving = true
        me.step_init = 4
        return
    end
    if me.sprite.steps >= RAISE_STEPS then
        me:set_animation(0x13)
        me.step = DROP
        me.step_init = 0
    end
end

-- `sub_80EE89C`: when the animation ends, the drop on the target.
local function drop(me: Object, s: State)
    if me.sprite.steps < DROP_STEPS then
        return
    end
    local x, found = enemy_column(me)
    local tx, ty
    if found then
        local y = me.panel_y
        for _, step in ROW_STEPS do
            y += step
            if field.any(x, y, ENEMY, me.alliance) then
                tx, ty = x, y
                break
            end
        end
    end
    if tx == nil then
        tx, ty = me.panel_x + me.facing * 3, me.panel_y
    end
    local damage = bit32.bor(me.attack_damage, bit32.lshift(me.hit_param, 16))
    erase_drop.spawn(me, tx :: number, ty :: number, FALL_TICKS, damage)
    battle.play_sound(SOUND)
    s.timer = 0x14
    me.step = RECOVER
    me.step_init = 0
end

-- `sub_80ED998`: 21 ticks, then idle.
local function recover(me: Object, s: State)
    local left = s.timer - 1
    s.timer = left
    if left >= 0 then
        return
    end
    me.status.moving = false
    me:exit_attack()
end

drop_weapon.action = new.action {
    id = "erasecross-beast/drop/action",
    state = { timer = schema.u16 },
    -- `sub_80EE840`.
    update = function(me: Object, s: State)
        local step = me.step
        if step == RAISE then
            raise(me)
        elseif step == DROP then
            drop(me, s)
        elseif step == RECOVER then
            recover(me, s)
        else
            error(string.format("EraseCross Beast's drop phase %#x reads past its phase table (sub_80EE840)", step))
        end
    end,
}

drop_weapon.weapon = new.weapon {
    id = "erasecross-beast/drop",
    -- The charge table's row 0x15, by Charge 0 to 7: past 4 it reads on
    -- into the next routine's row, as the original's table does.
    charge_ticks = { 120, 120, 120, 120, 120, 120, 110, 100 },
    setup = setup,
}

return drop_weapon
