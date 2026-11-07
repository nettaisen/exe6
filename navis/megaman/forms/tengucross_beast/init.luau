--!strict
-- TenguCross Beast: one of MegaMan's forms.

local tenguman = require("../../tenguman").tenguman
local falzar_beast = require("./falzar_beast")["falzar-beast"]
local falzar_beast_buster = require("../weapons/falzar_beast_buster")
local tengu_wind = require("../weapons/tengu_wind")
local charged_chip_bonus = require("../weapons/charged_chip_bonus")
local charge = require("@self/charge")
local forms = require("../../../rules/forms")
local beast_head_sprite = asset.sprite("beast-head")
local tengucross_beast_sprite = asset.sprite("tengucross-beast")

local form: FormDef = {
    kind = "cross_beast",
    -- The Falzar Beast buster's shots' palette (`byte_80EC784`).
    beast_shot_palette = 3,
    -- What changes MegaMan into it (EXE6's five sequences).
    change = forms.action,
    version = Version.falzar,
    cross_of = tenguman,
    -- A weakness hit breaks the Cross: back to the Beast.
    breaks_to = falzar_beast,
    sprite = tengucross_beast_sprite,
    element = Element.null,
    weakness = { sword = true },
    buster_bonus = 0,
    weapons = {
        buster = falzar_beast_buster.weapon,
        back_special = tengu_wind.weapon,
        a_charge = charged_chip_bonus,
        alt_a_charge = charge.weapon,
    },
    mugshot = asset.mugshot("tengucross-beast"),
    -- The damage it adds to its family's damaging chips.
    chip_bonus = { family = Family.wind, damage = 10 },
    -- Beast Out: its damaging Null chips' bonus, where the family's doesn't apply.
    null_bonus = 30,
    -- The chips A charges.
    charged_chips = { { family = Family.null, damaging = false } },
    -- What its status reset gives the navi (`sub_8014536`).
    status_reset = { air_shoes = true, float_shoes = true, floating_body = true, target_marker = true },
    -- The Cross special's buster volley (`sub_802D4F0`): the original meant 6, and stores the form's number.
    special_volley = 20,
    -- The target marker shows, its afterimages stay, and a Null chip's A charge times by the
    -- alternative routine (`sub_80E1566`, `sub_80E341E`, `sub_8012F62`).
    traits = {
        special_holds_buster = true,
        shows_target_marker = true,
        afterimages_stay = true,
        alt_charge_time = true,
    },
    -- The buster arm it raises (lib/buster).
    buster_arm = { anim = 20 },
    identity = new.identity {
        class = IdentityClass.player,
        changes_form = true,
        breaks_on_weakness = true,
        version = 0,
        actor_type = ActorType.player,
        ai_index = 44,
        -- The Full Synchro aura's animation, and the ice block that fits.
        aura_anim = 13,
        ice = IceSize.medium,
        -- The beast's head, in the Cross's palette.
        parts = { beast_head = { sprite = beast_head_sprite, palette = 6 } },
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

return { ["tengucross-beast"] = form }
