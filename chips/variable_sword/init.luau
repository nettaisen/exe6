--!strict
-- VarSwrd (the original's action 0x53, `sub_80EF62E`): the navi holds A
-- and enters a direction sequence (lib/swords/vari): a quarter circle
-- forward (down, down-forward, forward) gives LongSwrd, a half circle from
-- back FtrSword, up-forward-down WideSwrd, down-back-up-forward-down
-- LifeSrd, and back, A+B, forward, A+B SonicBom. Letting go of A, or 48
-- ticks, gives a Sword.

local fighter_sword = require("./fighter_sword").fighter_sword
local life_sword = require("./life_sword").life_sword
local long_sword = require("./long_sword").long_sword
local sonic_boom = require("./sonic_boom").sonic_boom
local sword = require("./sword").sword
local vari = require("../lib/swords/vari")
local wide_sword = require("./wide_sword").wide_sword

local chip: Chip = {
    codes = { "K", "V", "W" },
    element = Element.null,
    family = Family.sword,
    class = ChipClass.standard,
    rarity = 2,
    mb = 28,
    damage = 160,
    counter = 30,
    lockout = 0,
    flags = { has_damage = true, standard_library = true, library = true },
    slot_in_limit = 3,
    traits = { no_chain = true },
    action = vari.action {
        id = "variable_sword/action",
        -- The sequences (`off_80EF670`, joypad words each ending in 0),
        -- not turned (facing right on side 0) and turned, each step the
        -- buttons held, A among them.
        sequences = {
            unturned = {
                { { a = true, down = true }, { a = true, right = true, down = true }, { a = true, right = true } },
                { { a = true, left = true }, { a = true, left = true, down = true }, { a = true, down = true }, { a = true, right = true, down = true }, { a = true, right = true } },
                { { a = true, up = true }, { a = true, right = true }, { a = true, down = true } },
                { { a = true, down = true }, { a = true, left = true }, { a = true, up = true }, { a = true, right = true }, { a = true, down = true } },
                { { a = true, left = true }, { a = true, b = true }, { a = true, right = true }, { a = true, b = true } },
            },
            turned = {
                { { a = true, down = true }, { a = true, left = true, down = true }, { a = true, left = true } },
                { { a = true, right = true }, { a = true, right = true, down = true }, { a = true, down = true }, { a = true, left = true, down = true }, { a = true, left = true } },
                { { a = true, up = true }, { a = true, left = true }, { a = true, down = true } },
                { { a = true, down = true }, { a = true, right = true }, { a = true, up = true }, { a = true, left = true }, { a = true, down = true } },
                { { a = true, right = true }, { a = true, b = true }, { a = true, left = true }, { a = true, b = true } },
            },
        },
        -- LongSwrd, FtrSword, WideSwrd, LifeSrd, SonicBom (`loc_80EF7D8`).
        picks = { long_sword, fighter_sword, wide_sword, life_sword, sonic_boom },
        sword = sword,
        -- SlashCross's A-charge runs it charged: its pick is what becomes
        -- the charged slash.
        charged = "own",
        random = 6,
        no_charged = sonic_boom,
    },
}

return { variable_sword = chip }
