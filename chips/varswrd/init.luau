--!strict
-- VarSwrd (the original's action 0x53, `sub_80EF62E`): the navi holds A
-- and enters a direction sequence (lib/swords/vari): a quarter circle
-- forward (down, down-forward, forward) gives LongSwrd, a half circle from
-- back FtrSword, up-forward-down WideSwrd, down-back-up-forward-down
-- LifeSrd, and back, A+B, forward, A+B SonicBom. Letting go of A, or 48
-- ticks, gives a Sword.

local ftrsword = require("./ftrsword").ftrsword
local lifesrd = require("./lifesrd").lifesrd
local longswrd = require("./longswrd").longswrd
local sonicbom = require("./sonicbom").sonicbom
local sword = require("./sword").sword
local vari = require("../lib/swords/vari")
local wideswrd = require("./wideswrd").wideswrd

local chip: Chip = {
    codes = { "K", "V", "W" },
    element = "null",
    family = "sword",
    class = "standard",
    rarity = 2,
    mb = 28,
    damage = 160,
    counter = 30,
    lockout = 0,
    flags = { "has_damage", "standard_library", "library" },
    slot_in_limit = 3,
    traits = { "no_chain" },
    action = vari.action {
        id = "varswrd/action",
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
        picks = { longswrd, ftrsword, wideswrd, lifesrd, sonicbom },
        sword = sword,
        -- SlashCross's A-charge runs it charged: its pick is what becomes
        -- the charged slash.
        charged = "own",
        random = 6,
        no_charged = sonicbom,
    },
}

return { varswrd = chip }
