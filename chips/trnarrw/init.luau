--!strict
-- TrnArrw1, TrnArrw2 and TrnArrw3 (the original's action 0x28,
-- `sub_80ECDFC`): the navi draws the bow (an attachment) and sets an arrow
-- (objects/flying_shot) over each panel ahead that lets one through, the
-- nearest leaving last (after 16, 12, 8, 4 and 0 ticks); 24 ticks later
-- it shoots one more from its own panel at once, and the bow's animation
-- steps on. It recovers for 16 ticks, the bow stepping on again when the
-- navi's animation ends. The three differ only in their damage.

local attachment = require("../objects/attachment")
local collision = require("../rules/collision")
local flying_shot = require("../objects/flying_shot")
local lockon = require("../rules/lockon")
local sparks = require("../lib/sparks")
local bow_sprite = asset.sprite("bow")

export type State = {
    -- Ticks of the draw so far, then the recovery's (AIAttackVars+0x10).
    timer: number,
}


-- One state for the three chips' draws.
local STATE = { timer = schema.u16 }

-- The phases, on the attack's step.
local DRAW, RECOVER = 0x0, 0x4
-- RECOVER's step_init: waiting for the navi's animation to end, then not.
local UNTIL_ANIM_END, AFTER = 1, 2

-- The bow (the original's attachment row 0x17).
local BOW = attachment.look { sprite = bow_sprite, palette = 0, attach_point = 0x17 }
-- The navi's attach point the arrows are shot from.
local HAND = 0x17
-- Panels an arrow passes over, of its side (`byte_80ECEAC`): on the field,
-- and none of the other side's bodies or other bodies, nor a neutral one.
local PASSES: PanelCondition = { on_field = true, enemy_body = false, enemy_other_body = false, neutral = false }
local SOUND_TWANG = asset.sound("twang")
-- The arrow (the flying shot's row 2): aqua, sparking over its panel's
-- center, with the twang as it sets off after its wait.
local ARROW = flying_shot.variant {
    collision = { is = collision.attack, hits = collision.hits_navis },
    hit_mod = { flinch = true },
    element = Element.aqua,
    spark = sparks.of_element(Element.aqua),
    sprite = bow_sprite,
    anim = 3,
    speed = 0x6_0000,
    range = 8,
    panel_spark = true,
    launch_sound = SOUND_TWANG,
}

-- `sub_80ECF00`: an arrow over (x, y), leaving after `delay` ticks: at the
-- panel's center a pixel up, at the navi's hand height (its sprite's
-- attach point, `sub_8018810`).
local function arrow(me: Object, x: number, y: number, delay: number)
    local cx, cy = field.center(x, y)
    local _, az = me:attach_point(HAND)
    local damage = me.attack_word
    -- (The game passes the attack variables' address as the shot's word;
    -- an arrow doesn't read it.)
    local pos = Vec3.new(cx, int.i32(cy - 0x10000), int.shl(az, 16))
    flying_shot.launch(me, pos, { variant = ARROW, wait = delay, damage = damage })
end

-- `sub_80ECE18`: the arrows, the bow; after 24 ticks the last arrow.
local function draw(me: Object, s: State)
    if me.step_init == 0 then
        -- The Atk+ bonus goes into the attack's damage word.
        local word = damage_word.plus(me.attack_word, me.extra)
        me.attack_word = word
        local dir = me.facing
        local x, y = me.panel_x, me.panel_y
        local delay = 0x14
        local passes = PASSES
        while true do
            x += dir
            delay -= 4
            if not field.check(x, y, passes, me.alliance) then
                break
            end
            arrow(me, x, y, bit32.band(delay, 0xFF))
        end
        me.anim = 0x0A
        me:open_counter_window()
        attachment.attach(me, BOW, "overlay")
        me.status.using_action = true
        s.timer = 0
        me.step_init = 4
    end
    local t = s.timer + 1
    s.timer = t
    if t < 0x18 then
        return
    end
    arrow(me, me.panel_x, me.panel_y, 0)
    battle.play_sound(SOUND_TWANG)
    local bow = me.overlay
    if bow then
        bow.anim += 1
    end
    me.step = RECOVER
    me.step_init = 0
end

-- Whether the navi's hold (animation 0xA, its own length: its `animation_steps`) has ended, or come round.
local function hold_ended(me: Object): boolean
    local steps = ((battle.navi(me.alliance).navi :: any) :: Exe6NaviFields).animation_steps
    local s = me.sprite.steps
    if steps.hold_loops then
        return s > 0 and s % steps.hold == 0
    end
    return s >= steps.hold
end

-- `sub_80ECEBC`: 16 ticks; when the navi's animation ends the bow steps
-- on; then the bow goes and back to idle.
local function recover(me: Object, s: State)
    local init = me.step_init
    if init == UNTIL_ANIM_END then
        if hold_ended(me) then
            local bow = me.overlay
            if bow then
                bow.anim += 1
            end
            me.step_init = AFTER
        end
    elseif init ~= AFTER then
        s.timer = 0x0F
        me.step_init = UNTIL_ANIM_END
    end
    local t = s.timer - 1
    s.timer = t
    if t < 0 then
        me.related1 = nil
        me.overlay = nil
        me:exit_attack()
    end
end

-- `sub_80ECDFC`.
local function update(me: Object, s: State)
    local step = me.step
    if step == DRAW then
        draw(me, s)
    elseif step == RECOVER then
        recover(me, s)
    else
        error(string.format("TrnArrw phase %#x reads past its phase table", step))
    end
end

-- A chip's draw.
local function shoot(): Action
    return new.action { state = STATE, update = update }
end

local trnarrw1: Chip = {
    codes = { "A", "F", "K" },
    element = Element.aqua, family = Family.aqua, class = "standard",
    rarity = 0, mb = 30, damage = 30, counter = 30, lockout = 0,
    flags = { has_damage = true, standard_library = true, library = true },
    slot_in_limit = 3,
    -- The Beast rush, and its lock-on mode (rules/lockon).
    beast = { lockon = lockon.trnarrw1 },
    action = shoot(),
}
local trnarrw2: Chip = {
    codes = { "G", "M", "Z" },
    element = Element.aqua, family = Family.aqua, class = "standard",
    rarity = 1, mb = 36, damage = 40, counter = 30, lockout = 0,
    flags = { has_damage = true, standard_library = true, library = true },
    slot_in_limit = 3,
    -- The Beast rush, and its lock-on mode (rules/lockon).
    beast = { lockon = lockon.trnarrw1 },
    action = shoot(),
}
local trnarrw3: Chip = {
    codes = { "M", "S", "Y" },
    element = Element.aqua, family = Family.aqua, class = "standard",
    rarity = 2, mb = 42, damage = 50, counter = 30, lockout = 0,
    flags = { has_damage = true, standard_library = true, library = true },
    slot_in_limit = 3,
    -- The Beast rush, and its lock-on mode (rules/lockon).
    beast = { lockon = lockon.trnarrw1 },
    action = shoot(),
}

return { trnarrw1 = trnarrw1, trnarrw2 = trnarrw2, trnarrw3 = trnarrw3 }
