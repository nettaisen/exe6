--!strict
-- NeoVari (the original's action 0x54, `sub_80EF7E2`): VarSwrd's scheme
-- (lib/swords/vari) with three sequences: down, forward, up gives CrosSwrd;
-- back, forward, back, A+B SprSonic; up, A+B, down, A+B, up, A+B DblDream.
-- Letting go of A, or 48 ticks, gives a Sword.

local cross_sword = require("./cross_sword").cross_sword
local double_dream = require("./double_dream").double_dream
local super_sonic = require("./super_sonic").super_sonic
local sword = require("./sword").sword
local vari = require("../lib/swords/vari")

local chip: Chip = {
    codes = { "N" },
    element = Element.null,
    family = Family.sword,
    class = ChipClass.standard,
    rarity = 3,
    mb = 52,
    damage = 220,
    counter = 30,
    lockout = 0,
    flags = { has_damage = true, standard_library = true, library = true },
    slot_in_limit = 1,
    traits = { no_chain = true },
    action = vari.action {
        id = "neo_variable_sword/action",
        -- The sequences (`off_80EF824`, joypad words each ending in 0),
        -- not turned (facing right on side 0) and turned (the up-down one
        -- is the same both ways), each step the buttons held, A among them.
        sequences = {
            unturned = {
                { { a = true, down = true }, { a = true, right = true }, { a = true, up = true } },
                { { a = true, left = true }, { a = true, right = true }, { a = true, left = true }, { a = true, b = true } },
                { { a = true, up = true }, { a = true, b = true }, { a = true, down = true }, { a = true, b = true }, { a = true, up = true }, { a = true, b = true } },
            },
            turned = {
                { { a = true, down = true }, { a = true, left = true }, { a = true, up = true } },
                { { a = true, right = true }, { a = true, left = true }, { a = true, right = true }, { a = true, b = true } },
                { { a = true, up = true }, { a = true, b = true }, { a = true, down = true }, { a = true, b = true }, { a = true, up = true }, { a = true, b = true } },
            },
        },
        -- CrosSwrd, SprSonic, DblDream (`byte_80EF958`).
        picks = { cross_sword, super_sonic, double_dream },
        sword = sword,
        -- SlashCross's A-charge runs it charged: its pick is what becomes
        -- the charged slash.
        charged = "own",
        random = 4,
        no_charged = super_sonic,
    },
}

return { neo_variable_sword = chip }
