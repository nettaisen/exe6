--!strict
-- What the pack takes from the Japanese ROMs (`ROCKEXE6_RXXBR6J`, JP Falzar, and `ROCKEXE6_GXXBR5J`, JP Gregar): what
-- the US release cut and left a placeholder in (docs/engine/jp-differences.md §4.4, §4.5). The same code reaches it as
-- in the US ROMs (the sprite list, the chip records: the other modules' places); here is which of it the pack takes
-- from a Japanese ROM, the Falzar one unless stated.
--
-- - Sprites: six slots of the sprite list hold the US ROMs' shared placeholder archive and the Japanese ROMs' own
--   (the same archive in both): Count (HackJack's navi), Django, Otenko's statue, the Falzar and Gregar chips'
--   beasts, and battle mode 1's "Blocking" label.
-- - Chip pictures: fifteen chips have a placeholder picture (a purple block) in the US ROMs: the eleven the US
--   release cut, and BatCan1 to BatCan4, which it kept the names of. The Japanese ROMs have their art.
-- - The chip records otherwise: a chip's icon and picture are its US ROM's (versions.luau's `chip_source`). Two
--   differ in the Japanese ROMs: the Falzar ROMs' icon for Bass and BassAnly (one pixel, (0, 8): color 3 in the
--   Japanese ROM, 9 in the US one) and the Gregar ROMs' Beast Out picture (two pixels, (53, 31) and (52, 32): clear
--   in the Japanese ROM, color 14 in the US one).
--
-- The pack has one picture of each: nettai draws it on every console. A US console shows the placeholder there,
-- which the verification's frame comparison knows (its table of what a console shows otherwise); the pack keeps no
-- mark of whose ROM a picture is from. Everything else is the US ROMs' where the releases differ.

local place = require("@exelib/extract/place")
local hud = require("./hud")

local jp = {}

-- The sprite slots (category's byte offset, index) the US ROMs fill with a placeholder archive and the Japanese ROMs
-- with their own, which the pack takes from a Japanese ROM.
jp.SPRITES = {
    -- Count (HackJack's navi, and his lances).
    { category = 0x08, index = 0x16 },
    -- Django: the Django chips' navi and bike, CrosOver's partner and his gun.
    { category = 0x0C, index = 0x0F },
    -- Otenko's statue (in the US ROMs the statue loads 0C-00 instead), and how it looks absorbed and thrown as junk.
    { category = 0x0C, index = 0x49 },
    -- The Falzar and Gregar chips' beasts.
    { category = 0x0C, index = 0x66 },
    { category = 0x0C, index = 0x68 },
    -- The effect table's entry 0x1D in the Japanese ROMs: battle mode 1's "Blocking" label, which no netbattle shows.
    { category = 0x14, index = 0x17 },
}

-- Whether sprite slot (category, index) is one the pack takes from a Japanese ROM.
function jp.has_sprite(category: number, index: number): boolean
    for _, s in jp.SPRITES do
        if s.category == category and s.index == index then
            return true
        end
    end
    return false
end

-- The chips whose picture each Japanese ROM has its own of: the Gregar and Falzar chips, which show the console's own
-- beast. The pack has each chip's own, Gregar's from the Japanese Gregar ROM, Falzar's from the Japanese Falzar ROM,
-- on either console.
local VERSIONED: { [number]: string } = { [0x138] = "BR5J", [0x139] = "BR6J" }

-- The chips whose picture is a placeholder in the US ROMs: GunDelEX, Otenko, HackJack (Count) ×3, Django ×3,
-- DblBeast, the Gregar and Falzar chips, and BatCan1 to BatCan4 (each the same in both Japanese ROMs but
-- `VERSIONED`'s).
local CHIP_PICTURES: { [number]: boolean } = {}
for _, id in { 0x012, 0x099, 0x113, 0x114, 0x115, 0x116, 0x117, 0x118, 0x137, 0x138, 0x139, 0x13B, 0x13C, 0x13D, 0x13E } do
    CHIP_PICTURES[id] = true
end

-- Where DblBeast's record says its palette is: EWRAM, which a gift received over the link fills (an e-Reader card's,
-- Card e+: `0x0813006C` copies the card's palette to 0x02000AF0 + 32 × slot, which the save keeps). That palette, the
-- card's, sits orphaned in the Japanese ROMs among the chip palettes, in DblBeast's place: after the palette of the
-- chip before it. The Gregar and Falzar chips' palettes (slot 1, 0x02000B10) are in no ROM: their definitions give
-- them (`art_palette`), and the pack's pictures have a black one.
local GIFT_PALETTE = 0x0200_0AF0

-- A cut chip's picture: the Japanese ROM it is read from (the chip's own version's for `VERSIONED`'s, the Falzar one
-- for the rest), the picture's address there and its palette's (nil: in no ROM). Nil for a chip that isn't cut.
function jp.chip_picture(set: Set, id: number): (Rom?, number, number?)
    if not CHIP_PICTURES[id] then
        return nil, 0, nil
    end
    local rom = set[VERSIONED[id] or "BR6J"]
    local function record(chip: number): number
        return place.at(rom, hud.CHIPS) + 0x2C * chip
    end
    local picture = rom:u32(record(id) + 0x24)
    local stated = rom:u32(record(id) + 0x28)
    local palette: number? = nil
    if stated == GIFT_PALETTE then
        palette = rom:u32(record(id - 1) + 0x28) + 0x20
    elseif stated >= 0x0800_0000 and stated < 0x0A00_0000 then
        palette = stated
    end
    return rom, picture, palette
end

return jp
