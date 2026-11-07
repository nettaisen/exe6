--!strict
-- EXE6's Cross window on the custom screen (docs/design/rules-in-luau.md
-- §4.4, S6): the Crosses offered (`sub_8029EF8`) and the window's Cross tab
-- (`sub_8026840`) as the screen opens; a Cross chosen in the window
-- (`sub_8028A78`'s A: the rules' `custom.choose_form`) and its window
-- (`sub_8027A58`, `sub_8027AAE`, `sub_8027ADE`); B taking the Cross back
-- (`sub_8029032`), and a click on it un-choosing it with the picks kept (the
-- rules' `custom.unchoose_form`); the form it puts the navi in at the turn's start
-- (`sub_802937A`); and the round's record of the Crosses used
-- (`dword_20349A0`). The window itself, UP opening it (`sub_8028B74`), its
-- opening (`sub_8027834`), its cursor and keys (`sub_802794A`), its closing
-- (`sub_802790C`) and a Cross's description, is each player's own layer's,
-- which shows the rules' form list (these fields, by their roles) as the
-- custom screen's `form_list` (rules/custom_screen.luau) says. Its state is
-- the rules', which the frontend draws the window from.

local custom_beast = require("../beast/custom")
local exe6 = require("../api")
local kind = require("../forms/kind")
local chip_gate_battle = require("../../lib/chip_gate_battle")

local window = {}

-- The rules' setup (rules/init.luau declares it): the Crosses they have:
-- up to five forms of either game, in the window's order, filled from the
-- front (docs/engine/custom-screen.md §4.1). The original's window offers
-- those of its version's five the save owns, by Cross number; a save the
-- game makes owns them in that order, so its list is its window.
export type Setup = {
    crosses: { FormDef? },
}

-- Event flag 0x163, a navi code received (`sub_800B144` sends its level
-- only then): no Beast Out button, and the Cross window then needs the
-- navi to be MegaMan (instead of the chip gate battle).
local function sealed(side: number): boolean
    return exe6.navi_level(side) ~= nil
end

-- The rules' state fields the window keeps (rules/init.luau declares
-- them).
export type State = {
    -- `dword_20349A0`: the Crosses used this round, by their place among
    -- the player's Crosses (0-4: the place in the setup's list, which is a
    -- save's version's Cross number); the round's first screen forgets
    -- them.
    crosses_used: { boolean },
    -- The screen's window (`+0x50`): the places of the Crosses offered,
    -- how many, which entry is chosen (one at most), and the place of the
    -- Cross chosen. (The entry under the window's cursor is the player's
    -- layer's.)
    offered: { number },
    offered_count: number,
    marked: { boolean },
    cross_chosen: boolean,
    chosen: number,
}

-- The Crosses a window offers at most: `sub_8029EC8` counts the five Cross flags of the save's version's table
-- (`byte_8029F4C`, `cmp r4, #5`), and the setup's list holds as many (rules/init.luau's `form[5]`).
local CROSSES = 5
-- The white fade of a Cross's choice (`sub_8027A58`), and the tick it is
-- white and the Cross is put on (`sub_8027AAE`: 16 ticks, then 8 steps of
-- the fade, then one more).
local FADE_SPEED = 0x20
local PUT_ON_TICK = 25
-- A Cross is put on (`sub_8027AAE`, 0x92).
local CHOSEN_SOUND = asset.sound("delta-ray-2")

-- The side's navi changes form (MegaMan).
local function megaman(side: number): boolean
    return battle.navi(side).navi.forms ~= nil
end

-- The player's Cross in place `place`: the setup's list's entry (of either
-- game); none past the list's end.
local function cross_at(_side: number, place: number): FormDef?
    return (rules.setup() :: Setup).crosses[place + 1]
end

-- The player has a Cross in place `place`.
local function owns_cross(side: number, place: number): boolean
    return cross_at(side, place) ~= nil
end

-- `sub_8029F70` (battle modes 0, 0xA and 0xB): not in a random battle; with
-- the link navi seal (event flag 0x163) only MegaMan, else not with
-- each side's own gauge (the chip gate battle).
local function crosses_allowed(side: number): boolean
    if custom.player(side).random_battle then
        return false
    end
    if sealed(side) then
        return megaman(side)
    end
    return not chip_gate_battle()
end

-- `sub_8029EC8`: how many Crosses the navi owns and hasn't used this round.
local function crosses_left(side: number): number
    local s = rules.state() :: State
    local n = 0
    for place = 0, CROSSES - 1 do
        if owns_cross(side, place) and not s.crosses_used[place + 1] then
            n += 1
        end
    end
    return n
end

-- What the list offers of its entries: Crosses only, and in a Beast form
-- only the Crosses whose Beast it is (that game's: their forms in Beast Out
-- are that Beast's). A save's Crosses are its own version's, which its
-- Beast is too, so the original has no case of it: a list of both games'
-- is nettai's.
local function listed_cross_fits(side: number, form: FormDef): boolean
    local current = battle.navi(side).form
    return form.kind == "cross" and not (kind.is_beast(current.kind) and form.version ~= current.version)
end

-- The form a Cross chosen (by its place) puts the navi in at the turn's
-- start (`sub_802937A`): the Cross, or in a Beast form its form in Beast
-- Out.
local function result_form(side: number, place: number): FormDef?
    local form = cross_at(side, place)
    if form ~= nil and kind.beast(side) then
        return form.beast
    end
    return form
end

-- `sub_802A088`: the face of the Cross chosen (by its place), its Beast
-- form's while the navi is in neither its base form nor a Cross.
local function cross_face(side: number, place: number): FormDef?
    local form = cross_at(side, place)
    if form == nil then
        return nil
    end
    local current = battle.navi(side).form
    if current.base or current.kind == "cross" then
        return form
    end
    return form.beast
end

-- The screen opens: the round's first forgets the Crosses used; the window
-- offers the Crosses owned, not used this round, and not the one the navi
-- starts battles in (`sub_8029EF8`), unless the navi is worn out; and the
-- window has the Cross tab while MegaMan has a Cross left this round.
function window.open(side: number)
    local s = rules.state() :: State
    if battle.turn() == 1 then
        for place = 1, CROSSES do
            s.crosses_used[place] = false
        end
    end
    for i = 1, CROSSES do
        s.offered[i] = 0
        s.marked[i] = false
    end
    s.offered_count = 0
    s.cross_chosen = false
    s.chosen = 0
    local allowed = crosses_allowed(side) and custom.player(side).emotion ~= Emotion.worn_out
    if allowed then
        local starting = battle.navi(side).starting_form
        for place = 0, CROSSES - 1 do
            local form = cross_at(side, place)
            if
                form ~= nil
                and owns_cross(side, place)
                and not s.crosses_used[place + 1]
                and form ~= starting
                and listed_cross_fits(side, form)
            then
                s.offered_count += 1
                s.offered[s.offered_count] = place
            end
        end
    end
    custom.set_form_list_tab(side, megaman(side) and allowed and crosses_left(side) ~= 0)
end

-- OK: the Cross chosen is used this round.
function window.confirmed(side: number)
    local s = rules.state() :: State
    if s.cross_chosen then
        s.crosses_used[s.chosen + 1] = true
    end
end

-- `sub_8028A78`'s A in the window (the player's layer shows it, as the custom
-- screen's `form_list` says: UP opens it from the top row or OK while
-- MegaMan has a Cross on offer and no other pick holds the turn's form,
-- Beast Out's): entry `entry` chosen, until a Cross is (a chosen one
-- refused). The Cross is marked and chosen, the form it puts the navi in
-- held, and its window plays; Beast Out grays out.
function window.choose(side: number, entry: number)
    local s = rules.state() :: State
    if s.cross_chosen or entry >= s.offered_count or not megaman(side) or custom.form_taken(side, Window.cross_chosen) then
        return
    end
    local i = entry + 1
    if s.marked[i] then
        custom.play(side, ScreenSound.refused)
        return
    end
    custom.play(side, ScreenSound.pick)
    s.marked[i] = true
    s.cross_chosen = true
    s.chosen = s.offered[i]
    custom.set_form(side, Window.cross_chosen, result_form(side, s.chosen))
    custom.open_window(side, Window.cross_chosen)
    -- A chosen Cross grays out Beast Out (its button's state).
    custom.refresh_buttons(side)
end

-- B with nothing picked takes the Cross chosen back (`sub_8029032`), as the player's un-choosing of it does with picks
-- too, which keeps them: the emotion window's face goes, or is a pick's again (the BeastOut chip's, which a Cross
-- chosen after it covered).
function window.unchoose(side: number): boolean
    local s = rules.state() :: State
    if not s.cross_chosen then
        return false
    end
    for i = 1, CROSSES do
        s.marked[i] = false
    end
    s.cross_chosen = false
    s.chosen = 0
    custom.set_form(side, Window.cross_chosen, nil)
    custom.set_face(side, custom_beast.picked_face(side))
    custom.play(side, ScreenSound.cancel)
    return true
end

-- `sub_8027A58`: 16 ticks, then the screen fades to white and back; when it
-- is white the Cross is put on (`sub_8027AAE`: the face, the window, the
-- sound), and when it is clear again the chips are chosen (`sub_8027ADE`).
window.chosen = {
    view = WindowView.form_chosen,
    update = function(side: number): boolean
        local s = rules.state() :: State
        local tick = custom.window_tick(side)
        if tick == 1 then
            custom.set_frame(side, 0)
        elseif tick <= 16 then
            custom.set_frame(side, custom.frame(side) + 1)
        elseif tick == 17 then
            custom.set_frame(side, 0)
            custom.fade(side, CustomFade.end_to_white, FADE_SPEED)
        elseif tick == PUT_ON_TICK then
            custom.fade(side, CustomFade.intro_from_white, FADE_SPEED)
            if s.cross_chosen then
                custom.set_face(side, cross_face(side, s.chosen))
            end
            custom.draw_window(side)
            custom.show_chip_window(side)
            custom.play_sound(side, CHOSEN_SOUND)
        elseif tick == 34 then
            custom.draw_window(side)
            custom.show_chip_window(side)
        end
        custom.draw_emblem(side, 0)
        custom.draw_regular(side)
        return tick < 34
    end,
} :: WindowSpec

return window
