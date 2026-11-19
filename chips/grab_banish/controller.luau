--!strict
-- GrabBnsh's and GrabRvng's dimming controller (the original's effect
-- object #0x22, `sub_80E2CA4`): the shared controller
-- (@exelib/grab_banish/controller), EXE6's kind with EXE6's hand (./hand), the
-- flash on each panel taken back (effect 0x3B) and its sound.

local common = require("@exelib/grab_banish/controller")
local hand = require("./hand")
local grab_shot_sprite = asset.sprite("grab_shot")

return common.make {
    id = "grab_banish/controller",
    hand = hand.kind,
    returned = new.effect { sprite = grab_shot_sprite, anim = 1, palette = 0, steps = 16 },
    return_sound = asset.sound("err_select_91"),
}
