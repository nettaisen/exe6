--!strict
-- HUD graphics for the pack. Everything here is uncompressed in the ROM; the HUD tasks (`sub_801BF64`) copy it to
-- VRAM as needed.
--
-- Each block is stated by where the game's own pointer to it is (a place: a routine's literal or a load list's entry,
-- at the same address in both versions' code where one pair of addresses is given), so any of the four ROMs gives
-- what it holds. The names in backticks are the US Falzar ROM's.

local place = require("@exelib/extract/place")
local banners = require("@exelib/extract/banners")
local texts = require("@exelib/extract/texts")
local chatbox = require("@exelib/extract/chatbox")
local versions = require("./versions")

local at = place.at
local pointer, pointer_in_each = place.pointer, place.pointer_in_each

local hud = {}

-- HUD layer tiles 0x1A0..=0x1D1: HP digits and blank, the box border, damage digits, '+' (`dword_86E1638`, the
-- battle's HUD load list's, `off_801ECB4`: twelve bytes a block, its source first).
local HUD_TILES = pointer(0x0801_ECC0, 0x0801_F0E4)
-- Tiles 0x1D2..=0x1D5: the '×' and '2' of a doubled chip (the list's next two blocks, two glyphs of the 8x16 font:
-- the Japanese font has its '×' at another number).
local TIMES_GLYPH = pointer(0x0801_ECD8, 0x0801_F0FC)
local TWO_GLYPH = pointer(0x0801_ECE4, 0x0801_F108)
-- Gauge tiles 0x222..=0x23D (`sub_801DED0`'s `dword_86E489C`), with the gauge's word on them: each release's own.
hud.GAUGE_TILES = pointer(0x0801_DF6C, 0x0801_E390)
hud.GAUGE_BYTES = 0x380
-- Background palette 9 (gauge) and 13 (HP box: + 0x20 per color state), `dword_86E1C78` (`sub_801DED0`'s too).
local HUD_PALETTES = pointer(0x0801_DF80, 0x0801_E3A4)
-- The initial HP box (6x2) and gauge frame (18x2) maps (`byte_801EDFC`, `byte_801ED6C`).
local HP_BOX = pointer(0x0801_E05C, 0x0801_E480)
local GAUGE_FRAME = pointer(0x0801_DEBC, 0x0801_E2E0)
-- The 8x16 font (glyph k = 0x40 bytes; `dword_86B7AE0`, the literal beside the text lines').
hud.FONT = pointer(0x0801_D1D0, 0x0801_D5F4)
hud.FONT_GLYPHS = 0xE0
-- The HUD's text lines (`TextScript86F0374`): a table of 16-bit offsets, then each line's glyphs up to its end mark.
hud.TEXTS = pointer(0x0801_D1C4, 0x0801_D5E8)
local TEXT_END = 0xE6
-- The chip records (`ChipDataArr_8021DA8`, the chip accessor's literal): 0x2C bytes a chip; +0x20 its icon, +0x24
-- its picture, +0x28 the picture's palette.
hud.CHIPS = pointer(0x0802_1AB0, 0x0802_1EC4)
hud.CHIP_COUNT = 411
-- The opponent's HP digits by color (`dword_86E0AB8`, `dword_86E0D38`, `dword_86E0FB8`), and their sprite palette
-- (`byte_86B7AC0`, the load list's first block).
local ENEMY_DIGITS = {
    pointer(0x0801_D854, 0x0801_DC78),
    pointer(0x0801_D880, 0x0801_DCA4),
    pointer(0x0801_D8AC, 0x0801_DCD0),
}
local ENEMY_PALETTE = pointer(0x0801_ECB4, 0x0801_F0D8)
-- A hidden chip's icon (`dword_872CE94`), and the icons' palette (the load list's `dword_872CFD4`).
local HIDDEN_ICON = pointer(0x0801_C160, 0x0801_C57C)
local ICON_PALETTE = pointer(0x0801_ED20, 0x0801_F144)
-- Mugshot graphics by emotion (`off_801CD08`) and palettes (`dword_872F114`). The first five are MegaMan's own in
-- both versions; the rest are the ROM's version's (versions.luau's `OWN_FACES`).
local MUGSHOTS = pointer(0x0801_CD04, 0x0801_D128)
local MUGSHOT_COUNT = 23
local MUGSHOT_PALETTES = pointer(0x0801_CD74, 0x0801_D198)
-- Count box with n = 10 - i at + 0x80 * i (`dword_872E994`), and the plain box (`dword_872D914`).
local COUNTS = pointer(0x0801_CDC4, 0x0801_D1E8)
local COUNT_BOX = pointer(0x0801_CD64, 0x0801_D188)
-- The link navis' mugshots (`sub_801CC34`): six faces of 0x100 bytes (`dword_872D094`), the box beside them
-- (`dword_872D014`), two palettes a face (normal, Full Synchro; `dword_872D694`). The first five are the ROM's
-- version's navis (versions.luau's `OWN_NAVI_FACES`), the sixth ProtoMan in both. (Which face each navi shows,
-- `byte_801CDDC`, is its definition's.)
local NAVI_MUGSHOTS = pointer(0x0801_CDCC, 0x0801_D1F0)
local NAVI_MUGSHOT_COUNT = 6
local NAVI_BOX = pointer(0x0801_CDD4, 0x0801_D1F8)
local NAVI_MUGSHOT_PALETTES = pointer(0x0801_CDD0, 0x0801_D1F4)
-- The dialogue font (`byte_86ACD60`: 16x12 glyphs, 0x60 bytes each, a row of eight bytes, the left pixel in each
-- byte's low nibble) and its advances (`byte_8043CA4`): the one-byte glyphs below 0xE4 and the two-byte codes' (E4 00
-- - E4 E8) after them. (The chatbox's code, past where the two versions' code parts: `off_803B638`, `off_8045ED8`.)
local DIALOGUE_FONT = pointer_in_each({ 0x0803_B638, 0x0803_B60C, 0x0803_C6B4, 0x0803_C688 })
local DIALOGUE_ADVANCES = pointer_in_each({ 0x0804_5ED8, 0x0804_5EA8, 0x0804_6F20, 0x0804_6EF0 })
local DIALOGUE_GLYPHS = 0xE4 + 0xE9
-- The chatbox (`chatbox_runScript`): the box's eleven tiles (to BG0's tile 0x2E4, which its maps count from;
-- `off_804046C`) and palette (`off_804047C`), the text's palette (the arrow's too; `off_8040484`); the box's maps
-- (`spritePtrArr8045CEC`: eight pointers a kind, the opening steps 0-3 first, 30x8 entries each), the message box
-- (`E8 00`) and the description box (`E8 06 01`); the key-wait arrow's three 16x16 frames (`chatbox_804082C`'s
-- `off_8040888`). Its palettes are as stored.
local CHATBOX: ChatboxPlaces = {
    tiles = pointer_in_each({ 0x0804_046C, 0x0804_0440, 0x0804_16A4, 0x0804_1678 }),
    tile_count = 11,
    first_tile = 0x2E4,
    palette = pointer_in_each({ 0x0804_047C, 0x0804_0450, 0x0804_16B4, 0x0804_1688 }),
    text_palette = pointer_in_each({ 0x0804_0484, 0x0804_0458, 0x0804_16BC, 0x0804_1690 }),
    boxes = pointer_in_each({ 0x0804_036C, 0x0804_0340, 0x0804_15A4, 0x0804_1578 }),
    kinds = 2,
    arrow = pointer_in_each({ 0x0804_0888, 0x0804_085C, 0x0804_1AC0, 0x0804_1A94 }),
    masked = false,
}
-- "PAUSE" (`off_801E188`): a 32x16 sprite's eight tiles and an 8x16 one's two.
local PAUSE = pointer(0x0801_E188, 0x0801_E5AC)
-- Banner descriptors (`pt_801EF84`: every banner up to the navis' win and deletion banners; `off_801E928`), their
-- glyph filler (`off_801E958`), digits (`off_801FD64`) and palette (`off_801E938`).
local BANNERS = pointer(0x0801_E928, 0x0801_ED4C)
local BANNER_COUNT = 47
local BANNER_FILLER = pointer(0x0801_E958, 0x0801_ED7C)
local BANNER_DIGITS = pointer(0x0801_FD64, 0x0802_0178)
hud.BANNER_PALETTE = pointer(0x0801_E938, 0x0801_ED5C)
-- "Cstmzing..." (16 tiles, drawn on the HUD layer in palette 10 = the banner palette; `off_801EF30`). The Japanese
-- ROMs' is 14 tiles.
hud.WAITING = pointer(0x0801_EF30, 0x0801_F354)
-- The warning marker's two 16x16 frames (`dword_86E55FC`, which the gauge chips' controller, VDoll's curse and
-- LifeSync copy to sprite tiles 0x3CA..=0x3D1; the custom screen's sprite list has them too, `off_802A744`'s second
-- block, which is the pointer read) and its palette (`byte_86E56FC`, sprite palette 13: the first of the emblems'
-- palettes, `sub_802812C`'s literal).
local WARNING = pointer_in_each({ 0x0802_A750, 0x0802_A74C, 0x0802_AB58, 0x0802_AB54 })
local WARNING_PALETTE = pointer(0x0802_8184, 0x0802_8598)

-- A palette of the HUD's, as stored.
function hud.palette(rom: Rom, a: number): Palette
    return gba.palette(rom, a)
end

-- The HUD's text lines in `rom` (a line with anything but glyphs in it, a text command, is cut there).
function hud.texts(rom: Rom): { { number } }
    return texts.lines(rom, at(rom, hud.TEXTS), TEXT_END, hud.FONT_GLYPHS)
end

-- Banner `id` of `rom`, in its release's words.
function hud.banner(rom: Rom, id: number): BannerLayout
    local table_at = at(rom, BANNERS)
    local filler = at(rom, BANNER_FILLER)
    return banners.at(rom, table_at, filler, id)
end

-- The first `n` of a list of characters.
local function first(list: { string }, n: number): { string }
    local out: { string } = {}
    for i = 1, math.min(n, #list) do
        table.insert(out, list[i])
    end
    return out
end

-- `rom`'s dialogue font with its advances, its glyphs drawing the 8x16 font's characters (`cell`), then the
-- dialogue font's past them.
function hud.dialogue_font(rom: Rom, cell: { string }, dialogue: { string }): DialogueFont
    local chars = table.clone(cell)
    for _, c in dialogue do
        table.insert(chars, c)
    end
    return font.dialogue(rom, at(rom, DIALOGUE_FONT), at(rom, DIALOGUE_ADVANCES), DIALOGUE_GLYPHS, 1, first(chars, DIALOGUE_GLYPHS))
end

-- The 8x16 font's characters, of an encoding's glyphs.
function hud.font_chars(glyphs: { string }): { string }
    return first(glyphs, hud.FONT_GLYPHS)
end

-- A chip's key as the pack has its icon and picture under (`chip-13a` where compat names none).
function hud.chip_key(names: AssetNames, id: number): string
    local keys = names.chips or {}
    return keys[id] or string.format("chip-%03x", id)
end

-- An emotion-window face of `rom`'s table: { tiles, palette }.
local function mugshot(rom: Rom, e: number): { any }
    local tiles = gba.tiles(rom, rom:u32(at(rom, MUGSHOTS) + 4 * e), 0x100)
    local palette = hud.palette(rom, at(rom, MUGSHOT_PALETTES) + 0x20 * e)
    return { tiles, palette }
end

-- A link navi's face of `rom`'s table.
local function navi_mugshot(rom: Rom, n: number): { tiles: Tiles, palettes: { Palette } }
    local tiles = gba.tiles(rom, at(rom, NAVI_MUGSHOTS) + 0x100 * n, 0x100)
    local palettes: { Palette } = {}
    for k = 0, 1 do
        table.insert(palettes, hud.palette(rom, at(rom, NAVI_MUGSHOT_PALETTES) + 0x40 * n + 0x20 * k))
    end
    return { tiles = tiles, palettes = palettes }
end

-- Every chip's icon, each from its own source (versions.luau's `icon_source`), under its chip's key: none where its
-- record has none in the ROM.
local function chip_icons(set: Set, names: AssetNames): { { key: string, tiles: Tiles? } }
    local out: { { key: string, tiles: Tiles? } } = {}
    for id = 0, hud.CHIP_COUNT - 1 do
        local rom = versions.icon_source(set, id)
        local p = rom:u32(at(rom, hud.CHIPS) + 0x2C * id + 0x20)
        local icon = if rom:holds(p) then gba.tiles(rom, p, 0x80) else nil
        table.insert(out, { key = hud.chip_key(names, id), tiles = icon })
    end
    return out
end

-- `h` with what the four ROMs have alike, read from `rom`.
local function drawn(rom: Rom, h: Hud)
    local hud_tiles = gba.join({
        gba.tiles(rom, at(rom, HUD_TILES), 0x640),
        gba.tiles(rom, at(rom, TIMES_GLYPH), 0x40),
        gba.tiles(rom, at(rom, TWO_GLYPH), 0x40),
    })
    local digits = gba.tiles(rom, at(rom, BANNER_DIGITS), 0x40 * 10)
    local blank = gba.tiles(rom, at(rom, BANNER_FILLER), 0x40)
    -- "PAUSE" as five glyphs: the first four are the 32x16 sprite's columns (its tiles go row by row), the fifth
    -- the 8x16 sprite.
    local pause = gba.tiles(rom, at(rom, PAUSE), 0x140):pick({ 0, 4, 1, 5, 2, 6, 3, 7, 8, 9 })
    h.tiles = hud_tiles
    h.first_tile = 0x1A0
    h.gauge_first_tile = 0x222
    local hp_palettes: { Palette } = {}
    for i = 0, 2 do
        table.insert(hp_palettes, hud.palette(rom, at(rom, HUD_PALETTES) + 0x20 * i))
    end
    h.hp_palettes = hp_palettes
    h.gauge_palette = hud.palette(rom, at(rom, HUD_PALETTES))
    h.hp_box = gba.map(rom, at(rom, HP_BOX), 12)
    h.gauge_frame = gba.map(rom, at(rom, GAUGE_FRAME), 36)
    local enemy_digits: { Tiles } = {}
    for _, p in ENEMY_DIGITS do
        table.insert(enemy_digits, gba.tiles(rom, at(rom, p), 0x40 * 10))
    end
    h.enemy_digits = enemy_digits
    h.enemy_palette = hud.palette(rom, at(rom, ENEMY_PALETTE))
    h.hidden_icon = gba.tiles(rom, at(rom, HIDDEN_ICON), 0x80)
    h.icon_palette = hud.palette(rom, at(rom, ICON_PALETTE))
    local counts: { Tiles } = {}
    for n = 0, 10 do
        table.insert(counts, gba.tiles(rom, at(rom, COUNTS) + 0x80 * (10 - n), 0x80))
    end
    h.counts = counts
    h.count_box = gba.tiles(rom, at(rom, COUNT_BOX), 0x80)
    h.navi_box = gba.tiles(rom, at(rom, NAVI_BOX), 0x80)
    h.pause = pause
    -- The banner font's digits, the filler's glyph after them as glyph 10.
    h.banner_digits = gba.join({ digits, blank })
    h.warning = gba.tiles(rom, at(rom, WARNING), 0x100)
    h.warning_palette = hud.palette(rom, at(rom, WARNING_PALETTE))
    h.chatbox = chatbox.of(rom, CHATBOX)
end

-- `h` with the words of `rom`'s release (a US ROM's: the pack's own language is English, and the Japanese ROMs'
-- words are lettering.luau's).
local function worded(rom: Rom, names: AssetNames, h: Hud)
    h.gauge_tiles = gba.tiles(rom, at(rom, hud.GAUGE_TILES), hud.GAUGE_BYTES)
    h.font = gba.tiles(rom, at(rom, hud.FONT), 0x40 * hud.FONT_GLYPHS)
    h.font_chars = hud.font_chars(names.glyphs or {})
    h.dialogue_font = hud.dialogue_font(rom, names.glyphs or {}, names.dialogue_glyphs or {})
    h.texts = hud.texts(rom)
    local list: { BannerLayout } = {}
    for id = 0, BANNER_COUNT - 1 do
        table.insert(list, hud.banner(rom, id))
    end
    h.banners = list
    h.banner_palette = hud.palette(rom, at(rom, hud.BANNER_PALETTE))
    h.waiting = gba.tiles(rom, at(rom, hud.WAITING), 0x200)
    h.waiting_palette = hud.palette(rom, at(rom, hud.BANNER_PALETTE))
end

-- The HUD's graphics; `names` gives the chip icons their chips' keys and the font its characters. What the four ROMs
-- have alike is the Falzar US ROM's (`drawn`); the English words the same ROM's (`worded`); a version's own faces and
-- chips' icons a ROM's of that version.
function hud.hud(set: Set, names: AssetNames): Hud
    local h: Hud = {}
    h.chip_icons = chip_icons(set, names)
    -- A ROM's table of faces: MegaMan's own, which both versions have, then its version's. The pack has the Falzar
    -- ROMs' table, then Gregar's own.
    local own = versions.OWN_FACES
    local mugshots: { { any } } = {}
    for e = 0, MUGSHOT_COUNT - 1 do
        table.insert(mugshots, mugshot(set.BR6E, e))
    end
    for e = own.first, own.last do
        table.insert(mugshots, mugshot(set.BR5E, e))
    end
    h.mugshots = mugshots
    -- Likewise the link navis': the version's five, then ProtoMan.
    local navi_mugshots: { { tiles: Tiles, palettes: { Palette } } } = {}
    for n = 0, NAVI_MUGSHOT_COUNT - 1 do
        table.insert(navi_mugshots, navi_mugshot(set.BR6E, n))
    end
    for n = 0, versions.OWN_NAVI_FACES - 1 do
        table.insert(navi_mugshots, navi_mugshot(set.BR5E, n))
    end
    h.navi_mugshots = navi_mugshots
    drawn(set.BR6E, h)
    worded(set.BR6E, names, h)
    return h
end

return hud
