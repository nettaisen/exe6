--!strict
-- GroundCross Beast: one of MegaMan's forms.

local groundman = require("../../groundman").groundman
local falzar_beast = require("./falzar_beast")["falzar-beast"]
local falzar_beast_buster = require("../weapons/falzar_beast_buster")
local rock_barrage = require("../weapons/rock_barrage")
local dash = require("@self/dash")
local forms = require("../../../rules/forms")
local beast_head_sprite = asset.sprite("beast-head")
local groundcross_beast_sprite = asset.sprite("groundcross-beast")

local form: FormDef = {
    kind = "cross_beast",
    -- The Falzar Beast buster's shots' palette (`byte_80EC784`).
    beast_shot_palette = 4,
    -- The target marker shows, its afterimages stay, and a Null chip's A charge times by the
    -- alternative routine (`sub_80E1566`, `sub_80E341E`, `sub_8012F62`).
    traits = { shows_target_marker = true, afterimages_stay = true, alt_charge_time = true },
    -- What changes MegaMan into it (EXE6's five sequences).
    change = forms.action,
    version = Version.falzar,
    cross_of = groundman,
    -- A weakness hit breaks the Cross: back to the Beast.
    breaks_to = falzar_beast,
    sprite = groundcross_beast_sprite,
    element = Element.null,
    weakness = { cursor = true },
    buster_bonus = 0,
    weapons = { buster = falzar_beast_buster.weapon, a_charge = rock_barrage, alt_a_charge = dash.weapon },
    mugshot = asset.mugshot("groundcross-beast"),
    -- The damage it adds to its family's damaging chips.
    chip_bonus = { family = Family["break"], damage = 10 },
    -- Beast Out: its damaging Null chips' bonus, where the family's doesn't apply.
    null_bonus = 30,
    -- The chips A charges.
    charged_chips = { { family = Family["break"], damaging = true }, { family = Family.null, damaging = false } },
    -- What its status reset gives the navi (`sub_8014536`).
    status_reset = {
        super_armor = true,
        air_shoes = true,
        float_shoes = true,
        floating_body = true,
        target_marker = true,
    },
    -- The Cross special's buster volley (`sub_802D4F0`): the original meant 6, and stores the form's number.
    special_volley = 21,
    -- The buster arm it raises (lib/buster).
    buster_arm = { anim = 21 },
    identity = new.identity {
        class = IdentityClass.player,
        changes_form = true,
        breaks_on_weakness = true,
        version = 0,
        actor_type = ActorType.player,
        ai_index = 45,
        -- The Full Synchro aura's animation, and the ice block that fits.
        aura_anim = 13,
        ice = IceSize.medium,
        -- The beast's head, in the Cross's palette.
        parts = { beast_head = { sprite = beast_head_sprite, palette = 8 } },
        attach_points = {
            { 4, 16 },
            { 4, 24 },
            { 4, 16 },
            { 9, 64 },
            { 9, 64 },
            { 9, 64 },
            { 16, 0 },
            { 16, 37 },
            { 16, 38 },
            { 24, 38 },
            { 17, 38 },
            { 17, 38 },
            { 18, 38 },
            { 22, 38 },
            { 22, 39 },
            { 24, 37 },
            { 40, 39 },
            { 9, 23 },
            { 29, 40 },
            { 40, 39 },
            { 18, 39 },
            { 4, 32 },
            { 22, 38 },
            { 22, 39 },
            { 24, 39 },
            { 20, 39 },
            { 25, 38 },
            { 4, 32 },
            { 88, 28 },
            { 114, 8 },
            { -8, 28 },
            { 65, 34 },
            { 4, 10 },
            { 4, 8 },
        },
    },
}

return { ["groundcross-beast"] = form }
