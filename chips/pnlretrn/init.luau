--!strict
-- PnlRetrn: a cut-in chip that turns the user's area back to normal
-- panels (`byte_80E272C` row 0).

local panel_changer = require("../objects/panel_changer")
local panel_chips = require("../lib/panel_chips/controller")

local chip: Chip = {
    codes = { "*" },
    element = "null", family = "null", class = ChipClass.standard,
    rarity = 1, mb = 14, damage = 0, counter = 0, lockout = 0,
    flags = { dimming = true, standard_library = true, library = true },
    extra_flags = { free_slot_in = true },
    slot_in_limit = 1,
    dimming = panel_chips.hook(panel_changer.change {
        panel = "normal",
        panels = "all",
        flicker = true,
        ticks = 0x40,
        condition = panel_chips.OWN_AREA,
        tick_sound = panel_changer.TICK_SOUND,
        change_sound = panel_changer.CHANGE_SOUND,
    }),
}

return { pnlretrn = chip }
