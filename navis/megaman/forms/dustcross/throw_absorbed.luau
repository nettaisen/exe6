--!strict
-- DustCross's buster (`dustcross/throw-absorbed`): the original's weapon
-- routine 0x2B (`sub_8011F8C`), the buster of a navi that absorbs
-- obstacles. It throws the last obstacle absorbed (the buster's shot as a
-- throw, 200 damage), or fires the plain buster when there is none.

local buster = require("../../weapons/buster")

local throw_absorbed = {}

local DAMAGE = 200

-- `sub_8011F8C`'s throw (`sub_8011FCE`'s too): the newest obstacle
-- absorbed (the navi's state's, the rules' `navi_state`) leaves the list
-- and goes into the attack; false when the navi has none.
function throw_absorbed.take(navi: Object): boolean
    local s = navi.state :: NaviState
    local absorbed = s.absorbed
    local n = #absorbed
    if n == 0 then
        return false
    end
    local newest = absorbed[n]
    local look, anim = newest.look, newest.anim
    local kept: { { look: AbsorbedLook, anim: number } } = {}
    for i = 1, n - 1 do
        kept[i] = { look = absorbed[i].look, anim = absorbed[i].anim }
    end
    s.absorbed = kept
    -- What it throws, which the game keeps in the action's marker word (the
    -- absorbed list's byte, kind | animation << 4, and the kind's sprite in
    -- the high half): the obstacle's look and animation.
    s.thrown_look, s.thrown_anim = look, anim
    navi.attack_damage = DAMAGE
    -- (The game sets the hit parameter to 0x94 and then clears it.)
    navi.hit_param = 0
    navi.attack_element = 0
    navi.charged = 0
    navi.extra = 0
    navi.attack_lockout = 0
    return true
end

-- `sub_8011F8C`.
local function setup(navi: Object): Action
    if throw_absorbed.take(navi) then
        return buster.throw(navi)
    end
    return buster.setup(navi)
end

throw_absorbed.weapon = new.weapon {
    id = "dustcross/throw-absorbed",
    -- The charge table's row 0x2B, by Charge 0 to 7: past 4 it reads on
    -- into the next routine's row, as the original's table does.
    charge_ticks = { 0, 0, 0, 0, 0, 0, 0, 0 },
    setup = setup,
}

return throw_absorbed
