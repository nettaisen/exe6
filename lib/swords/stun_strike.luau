--!strict
-- The stun strike (`sub_80EEB4C` started from idle): what a navi's
-- stun-strike request starts, a machine sword's strike with the attack as
-- it stands. The original starts its action 0x49 without setting the
-- attack up, so which strike is by the subtype the last chip left there:
-- MchnSwrd's (0: every paralyzed opposing navi), ElemSwrd's (1) or
-- AssnSwrd's (2). Here the attack holds its chip, not a subtype: ElemSwrd
-- or AssnSwrd left there strikes as itself, anything else as MchnSwrd
-- (the original's subtype 0, which most chips have; another chip of
-- subtype 1 or 2 would pick the other strikes there). Nothing in the game
-- sets the request.

local assassin_sword = require("../../chips/assassin_sword").assassin_sword
local element_sword = require("../../chips/element_sword").element_sword
local machine_sword = require("../../chips/machine_sword").machine_sword
local strike = require("./strike")

return {
    action = new.action {
        id = "stun_strike/action",
        state = strike.STATE,
        update = function(me: Object, s: any)
            local chip = me.attack_chip
            local sword = if chip ~= nil and (chip == element_sword or chip == assassin_sword) then chip else machine_sword;
            (sword.action :: Action).update(me, s)
        end,
    },
}
