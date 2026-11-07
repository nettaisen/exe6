--!strict
-- HolyPanl: a cut-in chip that makes the panel in front of the user holy
-- (`byte_80E272C` row 4).

local panel_changer = require("../objects/panel_changer")
local panel_chips = require("../lib/panel_chips/controller")

local chip: Chip = {
    codes = { "A", "B", "S", "*" },
    element = Element.null, family = Family.null, class = ChipClass.standard,
    rarity = 1, mb = 24, damage = 0, counter = 0, lockout = 0,
    flags = { dimming = true, standard_library = true, library = true },
    slot_in_limit = 1,
    dimming = panel_chips.hook(panel_changer.change {
        panel = PanelType.holy,
        panels = "front",
        flicker = true,
        ticks = 0x40,
        condition = panel_chips.ANY,
        tick_sound = panel_changer.TICK_SOUND,
        change_sound = panel_changer.CHANGE_SOUND,
    }),
}

return { holypanl = chip }
