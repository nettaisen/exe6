--!strict
-- The custom screen's graphics. Everything is uncompressed in the ROM: the battle's HUD load list (`off_801ECB4`) puts
-- the window's tiles and palettes in place at the battle's start, and the screen copies the rest as it runs
-- (`sub_80284E2` the chip window, `sub_8028250` the slots, `off_802A744` its sprites).
--
-- Each block is stated by where the game's own pointer to it is (a place, as the HUD's are), so any of the four ROMs
-- gives what it holds: the window and its parts are the same in the four, the chip window's worded pictures each
-- release's own, and a version's own pictures its ROMs'. The custom screen drops each color's bit 15.

local place = require("@exelib/extract/place")
local colors = require("@exelib/extract/colors")
local patches = require("@exelib/extract/patches")
local buttons = require("@exelib/extract/buttons")
local hud = require("./hud")
local versions = require("./versions")
local jp = require("./jp")

local at = place.at
local pointer, pointer_in_each = place.pointer, place.pointer_in_each

local custom = {}

-- A block: its place and its length in bytes.
type Block = { place: Place, len: number }

-- The window frame's tiles, loaded at tile 1 (0x87 tiles; the battle's HUD load list's, `off_801ECB4`, as the three
-- blocks after it are).
local WINDOW_TILES: Block = { place = pointer(0x0801_ECF0, 0x0801_F114), len = 0x10E0 }
-- The picked-chip column's cells, at tile 0x89.
local COLUMN_CELLS: Block = { place = pointer(0x0801_ECFC, 0x0801_F120), len = 0x80 }
-- The late turns' block, at tile 0x8D (`sub_8029D34`).
local TURN_LIMIT: Block = { place = pointer(0x0801_ED38, 0x0801_F15C), len = 0x1C0 }
-- The enemy names' bar, at tile 0x1D6 (`sub_801E4F4`).
local NAME_BAR: Block = { place = pointer(0x0801_ED50, 0x0801_F174), len = 0x80 }
-- The window's 15x20 maps: without and with the Cross tab (`sub_8026840`), and the patch list laid over them from
-- tile 0x9B.
local WINDOW_MAPS = { pointer(0x0802_69A0, 0x0802_6DB0), pointer(0x0802_69A4, 0x0802_6DB4) }
local WINDOW_PATCHES = pointer(0x0802_69AC, 0x0802_6DBC)
-- The Cross window's maps (`sub_8027834`: three opening steps, then one to five Crosses) and its patch list, from tile
-- 0xE1.
local CROSS_MAPS = pointer(0x0802_78E0, 0x0802_7CF4)
local CROSS_MAP_COUNT = 8
local CROSS_PATCHES = pointer(0x0802_7904, 0x0802_7D18)
local MAP_CELLS = 15 * 20
-- Background palette 9 by the chip window's class (`byte_86E587C`), and palettes 11, 12 and 14 (the HUD load list).
local FRAME_PALETTES = pointer(0x0802_8818, 0x0802_8C2C)
local FRAME_PALETTE_COUNT = 4
local ICON_PALETTE = pointer(0x0801_ED08, 0x0801_F12C)
local GRAY_PALETTE = pointer(0x0801_ED14, 0x0801_F138)
local OTHER_PALETTE = pointer(0x0801_ED2C, 0x0801_F150)
-- A chip window picture's bytes (7x6 tiles).
local PICTURE_BYTES = 0x540
-- The chip window's other pictures and their palettes (the literals of `sub_80286D4`, `sub_8028754`, `sub_80287A4`,
-- `sub_802877C`): each release's own words.
type Details = { gfx: Place, palette: Place }
custom.OK = { gfx = pointer(0x0802_8708, 0x0802_8B1C), palette = pointer(0x0802_8714, 0x0802_8B28) } :: Details
custom.OK_PICKED = { gfx = pointer(0x0802_870C, 0x0802_8B20), palette = pointer(0x0802_8718, 0x0802_8B2C) } :: Details
custom.OTHER = { gfx = pointer(0x0802_8774, 0x0802_8B88), palette = pointer(0x0802_8778, 0x0802_8B8C) } :: Details
custom.REDEAL = { gfx = pointer(0x0802_87EC, 0x0802_8C00), palette = pointer(0x0802_87F8, 0x0802_8C0C) } :: Details
custom.SCRAP = { gfx = pointer(0x0802_879C, 0x0802_8BB0), palette = pointer(0x0802_87A0, 0x0802_8BB4) } :: Details
-- Chip codes (8x16, `dword_86E2E98`), element icons and their colors (`dword_86E3598`, `dword_86E3B18`: six colors
-- each), damage digits (`dword_86E411C`).
local CODES = pointer(0x0802_8640, 0x0802_8A54)
local CODE_GLYPHS = 28
local ELEMENTS = pointer(0x0802_8648, 0x0802_8A5C)
local ELEMENT_COUNT = 11
local ELEMENT_COLORS = pointer(0x0802_8680, 0x0802_8A94)
local DIGITS = pointer(0x0802_8650, 0x0802_8A64)
local DIGIT_GLYPHS = 11
-- The slots' codes (16x8, `dword_86E591C`), the empty slot's icon, and the re-deal and scrap buttons
-- (`dword_86E441C`, `dword_86E4D9C`; Beast Out's, `byte_86E79CC`, is the version's).
local SLOT_CODES = pointer(0x0802_8230, 0x0802_8644)
local SLOT_CODE_GLYPHS = 28
local EMPTY_ICON = pointer(0x0802_81C0, 0x0802_85D4)
local REDEAL_BUTTONS: Block = { place = pointer(0x0802_835C, 0x0802_8770), len = 0x480 }
-- DustCross's has a fourth state, pressed (`sub_8028340`: 0x180 bytes a state).
local SCRAP_BUTTONS: Block = { place = pointer(0x0802_8360, 0x0802_8774), len = 0x600 }
-- Sprites: the cursor's corner (`off_802A744`: the list is four bytes earlier in the Gregar ROMs), the navis'
-- emblems and their palettes by navi (`sub_802812C`), the Regular chip's frame (`sub_802899C`).
local CURSOR: Block = { place = pointer_in_each({ 0x0802_A744, 0x0802_A740, 0x0802_AB4C, 0x0802_AB48 }), len = 0x40 }
-- The Cross window's cursor (`off_802A744`'s fourth block, to sprite tile 0x392).
local CROSS_CURSOR: Block = { place = pointer_in_each({ 0x0802_A768, 0x0802_A764, 0x0802_AB70, 0x0802_AB6C }), len = 0x80 }
-- Sprite palette 14, which the battle loads (`byte_86A5D40`, by the load list `off_81271C8`).
local CROSS_CURSOR_PALETTE = pointer_in_each({ 0x0812_7224, 0x0812_9000, 0x0812_F200, 0x0813_0FC8 })
-- `sub_802812C`: which of its ROM's seven emblems a navi shows, and in which of the palettes (`byte_802819C`,
-- `byte_802818C`); the pictures (`dword_86F5834`) and the palettes (`byte_86E56FC`).
local EMBLEM_OF = pointer(0x0802_8198, 0x0802_85AC)
local EMBLEM_PALETTE_OF = pointer(0x0802_8188, 0x0802_859C)
local EMBLEMS = pointer(0x0802_8180, 0x0802_8594)
local EMBLEM_PALETTES = pointer(0x0802_8184, 0x0802_8598)
local LINK_NAVIS = 12

-- The names EXE6's rules give their buttons (rules/init.luau: ChpShufl's `redeal`, DustCross's `scrap`, Beast Out's
-- `beast_out`), which the pack has their looks by.
custom.REDEAL_BUTTON = "redeal"
custom.SCRAP_BUTTON = "scrap"
local BEAST_OUT_BUTTON = "beast_out"

-- The cursor over OK (`sub_80288D0`, `byte_80288E4`).
local OK_CURSOR = buttons.cursor(0x58 + 3, 0x70 - 2, {
    { { 2, 1, false, false }, { 2, 0x16, true, false }, { 0x14, 0x16, true, true }, { 0x14, 1, false, true } },
    { { 4, 3, false, false }, { 4, 0x14, true, false }, { 0x12, 0x14, true, true }, { 0x12, 3, false, true } },
})

-- Where the blocks load among the HUD layer's tile numbers (`sub_8026840`, `sub_8028250`, `byte_8029DF8`).
local LAYOUT: CustomLayout = {
    column_cells = 0x89,
    turn_limit = 0x8D,
    turn_limit_palette = 9,
    name = 0x9B,
    art = 0xAB,
    code = 0xD5,
    element = 0xD7,
    digits = 0xDB,
    slots = 0xE1,
    column_icons = 0x125,
    name_bar = 0x1D6,
    form_names = 0x139,
    slot_blank = 1,
    detail_blank = 8,
    ok_cursor = OK_CURSOR,
    regular = { 2, 100 },
    column_columns = { 11, 14 },
    column_row = 3,
    form_names_at = { 1, 1 },
}

-- The cursor over the special slot's button (Beast Out: `sub_8028904`, `byte_8028918`), and over a button two slots
-- wide in the slots' row (the re-deal and scrap buttons, over slots 8 and 9: `sub_8028820`).
local SPECIAL_CURSOR = buttons.cursor(0x58 + 3, 0x88 - 1, {
    { { 2, 1, false, false }, { 2, 0x16, true, false }, { 0xE, 0x16, true, true }, { 0xE, 1, false, true } },
    { { 3, 2, false, false }, { 3, 0x15, true, false }, { 0xD, 0x15, true, true }, { 0xD, 2, false, true } },
})
local ROW_BUTTON_CURSOR = buttons.cursor(0x38, 0x80, {
    { { 2, 2, false, false }, { 2, 0x1C, true, false }, { 0x14, 0x1C, true, true }, { 0x14, 2, false, true } },
    { { 4, 4, false, false }, { 4, 0x1A, true, false }, { 0x12, 0x1A, true, true }, { 0x12, 4, false, true } },
})
local REGULAR: Block = { place = pointer(0x0802_89D8, 0x0802_8DEC), len = 0x400 }
-- The Program Advance animation's names' colors (`byte_802BA48`: three sets of four).
local ADVANCE_NAME_COLORS = pointer(0x0802_BA10, 0x0802_BE20)
local ADVANCE_NAME_SETS = 3

-- What a version's own custom screen shows (`VersionPictures`): the same code's literals in every ROM, each ROM
-- holding its own version's. The Beast Out button's picture and its palettes (`sub_802871C`'s literals: the BeastOut
-- chip's record's picture) and its states (`sub_8028250`'s `byte_86E79CC`); the forms' names (`sub_8029D94`'s
-- `dword_86E7DCC`: ten names of 0x240 bytes, in the release's words) and their palettes (`sub_8029EAC`'s
-- `dword_86E944C`: ten).
local BEAST_OUT = { gfx = pointer(0x0802_874C, 0x0802_8B60), palette = pointer(0x0802_8750, 0x0802_8B64) } :: Details
local BEAST_BUTTONS: Block = { place = pointer(0x0802_83A0, 0x0802_87B4), len = 0x400 }
custom.FORM_NAMES = { place = pointer(0x0802_9DD8, 0x0802_A1EC), len = 10 * 0x240 } :: Block
local FORM_NAME_PALETTES = pointer(0x0802_9EC0, 0x0802_A2D4)
local FORM_NAME_PALETTE_COUNT = 10

-- A block's tiles in `rom`.
function custom.tiles(rom: Rom, b: Block): Tiles
    return gba.tiles(rom, at(rom, b.place), b.len)
end

-- A palette as the hardware shows it: bit 15 of a color is ignored (the pictures of the chips the US release cut
-- hold 0xCCCC).
local function palette_at(rom: Rom, a: number): Palette
    return colors.masked(gba.palette(rom, a))
end

-- The first `n` palettes of a block in `rom`.
local function palettes(rom: Rom, p: Place, n: number): { Palette }
    local out: { Palette } = {}
    for i = 0, n - 1 do
        table.insert(out, palette_at(rom, at(rom, p) + 32 * i))
    end
    return out
end

local function picture_at(rom: Rom, gfx: number, pal: number): Picture
    return { tiles = gba.tiles(rom, gfx, PICTURE_BYTES), palette = palette_at(rom, pal) }
end

-- A picture of the chip window in `rom`, with its palette.
function custom.picture(rom: Rom, d: Details): Picture
    local gfx = at(rom, d.gfx)
    local pal = at(rom, d.palette)
    return picture_at(rom, gfx, pal)
end

local function map(rom: Rom, a: number): Map
    return gba.map(rom, a, MAP_CELLS)
end

local function rom_pointer(p: number): boolean
    return p >= 0x0800_0000 and p < 0x0A00_0000
end

-- A version's own pictures, from its US ROM: the Beast Out button, the version's Beast's (`sub_8028250`: 4x2 a set:
-- selectable, unavailable, battle mode 1's, and the hidden slot's), with its picture in the chip window; the forms'
-- names in its release's English words. The picture's palette is the first of two (`sub_802871C` takes the one the
-- special slot's +6 numbers, which EXE5's soul button sets for a Chaos Unison, 0x08024540, and nothing in EXE6 sets):
-- the pack leaves the second out.
local function version_pictures(set: Set, version: string): VersionPictures
    local rom = versions.rom(set, version)
    local picture = custom.picture(rom, BEAST_OUT)
    local beast_out: ButtonPictures = {
        width = 4,
        height = 2,
        tiles = custom.tiles(rom, BEAST_BUTTONS),
        sets = "other",
        hidden = 3,
        cursor = SPECIAL_CURSOR,
        palettes = { picture.palette :: Palette },
        picture = picture,
    }
    return {
        buttons = { { name = BEAST_OUT_BUTTON, value = beast_out } },
        form_names = custom.tiles(rom, custom.FORM_NAMES),
        form_name_palettes = palettes(rom, FORM_NAME_PALETTES, FORM_NAME_PALETTE_COUNT),
    }
end

-- A button two slots wide in the slots' row, with its picture in the chip window.
local function row_button(rom: Rom, b: Block, details: Details): ButtonPictures
    local picture = custom.picture(rom, details)
    return buttons.row(custom.tiles(rom, b), picture, ROW_BUTTON_CURSOR)
end

-- The navis' emblems (`sub_802812C`): navi n's picture is the ROM's `byte_802819C[n]`th and its palette the
-- `byte_802818C[n]`th, the same tables and palettes in every ROM. A ROM has pictures for MegaMan, its own version's
-- five link navis and ProtoMan, and shows the other version's five with its own five's pictures (a Falzar console's
-- HeatMan has SpoutMan's, in HeatMan's colors). The pack has each navi's own, from a ROM that has it (navis 1 to 5,
-- HeatMan to ChargeMan: Gregar's; 6 to 10, SpoutMan to GroundMan: Falzar's), under the navi's key: a navi compat
-- doesn't name has none.
local function emblems(set: Set, names: AssetNames): { Emblem }
    local keys = names.navis or {}
    local out: { Emblem } = {}
    for n = 0, LINK_NAVIS - 1 do
        local rom = if n >= 1 and n <= 5 then set.BR5E else set.BR6E
        local picture = rom:u8(at(rom, EMBLEM_OF) + n)
        local color = rom:u8(at(rom, EMBLEM_PALETTE_OF) + n)
        local navi = keys[n]
        if navi ~= nil then
            local emblem: Emblem = {
                navi = navi,
                tiles = gba.tiles(rom, at(rom, EMBLEMS) + 0x80 * picture, 0x80),
                palette = palette_at(rom, at(rom, EMBLEM_PALETTES) + 32 * color),
            }
            table.insert(out, emblem)
        end
    end
    return out
end

-- Chip `id`'s picture: the Falzar ROMs', the Gregar ROMs' for the five they have right, the US ROM's (versions.luau's
-- `chip_source`); a Japanese ROM's for the chips the US ROMs have a placeholder for (jp.luau's `chip_picture`). A
-- version's own chip's is marked with its version: a console of the other version shows its counterpart's there. A
-- cut chip whose palette no ROM holds (the Gregar and Falzar chips': a Card e+ gift's, kept in the save) gets a black
-- one; its definition gives the palette (`art_palette`).
local function chip_art(set: Set, names: AssetNames, id: number): ChipArt
    local key = hud.chip_key(names, id)
    local cut, gfx, pal = jp.chip_picture(set, id)
    if cut ~= nil then
        local tiles = gba.tiles(cut, gfx, PICTURE_BYTES)
        local palette = if pal ~= nil then palette_at(cut, pal) else { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
        return { key = key, picture = { tiles = tiles, palette = palette } }
    end
    local version = versions.chip_version(id)
    local rom = versions.chip_source(set, id)
    local record = at(rom, hud.CHIPS) + 0x2C * id
    local picture_gfx, picture_pal = rom:u32(record + 0x24), rom:u32(record + 0x28)
    local picture: Picture = {}
    if rom_pointer(picture_gfx) and rom_pointer(picture_pal) then
        picture = picture_at(rom, picture_gfx, picture_pal)
    end
    return { key = key, picture = picture, version = version }
end

-- The window's labels, in its tiles (`WINDOW_TILES`, the four ROMs' alike): BATTLE CHIP on its top frame (tiles 2 to
-- 10, color 7 on 6), CHIP SELECT over the slots (0x27 to 0x2D, 4 on 1), CROSS SELECT on the Cross tab (0x4A to 0x54, 5
-- on 2: its triangle stays) and in the Cross window's header (0x58 to 0x62), and B:EXIT at its foot (0x81 to 0x87: 5
-- and its B's 3, on 2). Each: its name, its tiles, its letters' rows, their colors.
local LABELS: { WindowLabel } = {
    { name = "battle-chip", first = 0x02, last = 0x0A, top = 1, bottom = 5, letters = { 7 } },
    { name = "chip-select", first = 0x27, last = 0x2D, top = 3, bottom = 6, letters = { 4 } },
    { name = "cross-select", first = 0x4A, last = 0x54, top = 2, bottom = 6, letters = { 5 } },
    { name = "cross-select", first = 0x58, last = 0x62, top = 1, bottom = 5, letters = { 5 } },
    { name = "b-exit", first = 0x81, last = 0x87, top = 2, bottom = 6, letters = { 5, 3 } },
}

-- `c` with what the four ROMs have alike, read from `rom`.
local function drawn(rom: Rom, c: CustomScreen)
    local function glyphs(p: Place, n: number): Tiles
        return gba.tiles(rom, at(rom, p), 0x40 * n)
    end
    c.labels = LABELS
    c.window_tiles = custom.tiles(rom, WINDOW_TILES)
    c.column_cells = custom.tiles(rom, COLUMN_CELLS)
    c.turn_limit = custom.tiles(rom, TURN_LIMIT)
    c.name_bar = custom.tiles(rom, NAME_BAR)
    local window_maps: { Map } = {}
    for _, p in WINDOW_MAPS do
        table.insert(window_maps, map(rom, at(rom, p)))
    end
    c.window_maps = window_maps
    c.window_patches = patches.list(rom, at(rom, WINDOW_PATCHES), 0x9B)
    local form_list_maps: { Map } = {}
    for i = 0, CROSS_MAP_COUNT - 1 do
        table.insert(form_list_maps, map(rom, at(rom, CROSS_MAPS) + 2 * MAP_CELLS * i))
    end
    c.form_list_maps = form_list_maps
    c.form_list_patches = patches.list(rom, at(rom, CROSS_PATCHES), 0xE1)
    c.frame_palettes = palettes(rom, FRAME_PALETTES, FRAME_PALETTE_COUNT)
    c.icon_palette = palette_at(rom, at(rom, ICON_PALETTE))
    c.gray_palette = palette_at(rom, at(rom, GRAY_PALETTE))
    c.other_palette = palette_at(rom, at(rom, OTHER_PALETTE))
    c.codes = glyphs(CODES, CODE_GLYPHS)
    c.elements = gba.tiles(rom, at(rom, ELEMENTS), 0x80 * ELEMENT_COUNT)
    local element_colors: { { number } } = {}
    for e = 0, ELEMENT_COUNT - 1 do
        local six: { number } = {}
        for i = 0, 5 do
            table.insert(six, rom:u16(at(rom, ELEMENT_COLORS) + 12 * e + 2 * i))
        end
        table.insert(element_colors, six)
    end
    c.element_colors = element_colors
    c.digits = glyphs(DIGITS, DIGIT_GLYPHS)
    c.slot_codes = glyphs(SLOT_CODES, SLOT_CODE_GLYPHS)
    c.empty_icon = gba.tiles(rom, at(rom, EMPTY_ICON), 0x80)
    c.cursor = custom.tiles(rom, CURSOR)
    c.form_list_cursor = custom.tiles(rom, CROSS_CURSOR)
    c.form_list_cursor_palette = palette_at(rom, at(rom, CROSS_CURSOR_PALETTE))
    c.regular = custom.tiles(rom, REGULAR)
    local advance_name_colors: { { number } } = {}
    for i = 0, ADVANCE_NAME_SETS - 1 do
        local four: { number } = {}
        for k = 0, 3 do
            local color: number = colors.color(rom:u16(at(rom, ADVANCE_NAME_COLORS) + 8 * i + 2 * k))
            table.insert(four, color)
        end
        table.insert(advance_name_colors, four)
    end
    c.advance_name_colors = advance_name_colors
end

-- The custom screen's graphics; `names` gives the chips' pictures their chips' keys. The window and its parts are the
-- Falzar US ROM's (`drawn`), the chip window's worded pictures too, each version's own pictures its US ROM's
-- (`version_pictures`), a chip's picture as `chip_art` says.
function custom.custom(set: Set, names: AssetNames): CustomScreen
    local rom = set.BR6E
    local falzar = version_pictures(set, versions.FALZAR)
    local gregar = version_pictures(set, versions.GREGAR)
    local redeal = row_button(rom, REDEAL_BUTTONS, custom.REDEAL)
    local scrap = row_button(rom, SCRAP_BUTTONS, custom.SCRAP)
    local chip_arts: { ChipArt } = {}
    for id = 0, hud.CHIP_COUNT - 1 do
        table.insert(chip_arts, chip_art(set, names, id))
    end
    local ok = custom.picture(rom, custom.OK)
    local ok_picked = custom.picture(rom, custom.OK_PICKED)
    local other = custom.picture(rom, custom.OTHER)
    local c: CustomScreen = {
        layout = LAYOUT,
        buttons = { { name = custom.REDEAL_BUTTON, value = redeal }, { name = custom.SCRAP_BUTTON, value = scrap } },
        versioned = { base_version = versions.FALZAR, base = falzar, versions = { { name = versions.GREGAR, value = gregar } } },
        chip_art = chip_arts,
        pictures = { ok = ok, ok_picked = ok_picked, other = other },
        emblems = emblems(set, names),
    }
    drawn(rom, c)
    return c
end

return custom
