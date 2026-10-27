--!strict
-- The field and the backgrounds.

local place = require("@exelib/extract/place")
local field = require("@exelib/extract/field")
local backgrounds = require("@exelib/extract/backgrounds")

local pointer, pointer_in_each = place.pointer, place.pointer_in_each

local stage = {}

-- The field's tiles (`dword_86DDBA0`, the battle's transfer list's).
local FIELD_TILES = pointer(0x0800_761C, 0x0800_7610)
-- Background palettes 1..=8 at battle start (`dword_86E08F8`, copied to the palette buffer's slot 1 by
-- `sub_80075CA`'s transfer list).
local FIELD_PALETTES = pointer(0x0800_75F0, 0x0800_75E4)
-- Panel blocks: 32 bytes (5x3 map entries) per 6 * type + 3 * owner + row - 1 (`byte_86DFA98`, read by
-- `sub_800C01C`).
local PANEL_BLOCKS = pointer(0x0800_C07C, 0x0800_C698)
-- Highlighted panel blocks (`dword_86E0458`, and `dword_86E0478` after it).
local HIGHLIGHT_BLOCKS = pointer(0x0800_C0F4, 0x0800_C710)
-- Front edges by owner (`byte_86E0498`, `sub_800C100`).
local FRONT_EDGES = pointer(0x0800_C16C, 0x0800_C788)
-- Panel palette animations run by `sub_800C192` (`off_800C1DC`).
local PANEL_PALETTE_ANIMS = pointer(0x0800_C1D4, 0x0800_C7F0)
-- The palette buffer address of background palette 0 (RAM: the same in the four ROMs).
local PALETTE_BUFFER = 0x0300_1960

-- EXE6's 13 panel types' names by number (`word_3007924`'s order: its blocks', a panel trail's byte's;
-- rules/panels.luau's `numbers`).
local PANEL_NAMES = {
    "missing", "broken", "normal", "cracked", "poison", "holy", "grass", "ice", "volcano", "road_up", "road_down",
    "road_left", "road_right",
}

-- The field, from `rom`.
function stage.field(rom: Rom): Field
    local a: FieldAddresses = {
        tiles = place.at(rom, FIELD_TILES),
        palettes = place.at(rom, FIELD_PALETTES),
        panels = place.at(rom, PANEL_BLOCKS),
        highlights = { place.at(rom, HIGHLIGHT_BLOCKS), place.at(rom, HIGHLIGHT_BLOCKS) + 32 },
        edges = place.at(rom, FRONT_EDGES),
        palette_anims = place.at(rom, PANEL_PALETTE_ANIMS),
        palette_buffer = PALETTE_BUFFER,
    }
    return field.read(rom, a, table.clone(PANEL_NAMES))
end

-- Background load data by background id (`off_8080F98`, `LoadBGAnimData`): gfx source, gfx dest, tilemap source,
-- tilemap dest offset, palette source, palette dest, palette size. (The backgrounds' code is past where the versions'
-- code parts: its literals are at an address of their own in each ROM.)
local BACKGROUNDS = pointer_in_each({ 0x0808_0F94, 0x0808_2054, 0x0808_3108, 0x0808_41C0 })
local BACKGROUND_COUNT = 22
-- Per background: scroll callbacks (`off_8080E34`, 16 bytes each; the second one scrolls BG1).
local BACKGROUND_SCROLL = pointer_in_each({ 0x0808_0E30, 0x0808_1EF0, 0x0808_2FA4, 0x0808_405C })
-- Per background: its GFX animation list (`off_8081220`).
local BACKGROUND_ANIMS = pointer_in_each({ 0x0808_0E2C, 0x0808_1EEC, 0x0808_2FA0, 0x0808_4058 })

-- Scroll callbacks and their counter steps (1/16 pixel per frame): the same routines at the same addresses in the
-- four ROMs.
local SCROLLERS: { [number]: { number } } = {
    [0x0800_19B4] = { -8, -4 }, -- BGScrollCB_BG1Diagonal3to2Scroll
    [0x0800_19EC] = { 0, -4 }, -- BGScrollCB_BG1UpScroll
    [0x0800_1A10] = { 0, 4 }, -- BGScrollCB_BG1DownScroll
    [0x0800_1A34] = { 1, 0 }, -- BGScrollCB_BG1SlowRightScroll
    [0x0800_1A58] = { -8, 0 }, -- BGScrollCB_BG1FastLeftScroll
}

-- The battle backgrounds by number, from `rom`.
function stage.backgrounds(rom: Rom): { [number]: Background, n: number }
    local loads = place.at(rom, BACKGROUNDS)
    local scrolls = place.at(rom, BACKGROUND_SCROLL)
    local anim_lists = place.at(rom, BACKGROUND_ANIMS)
    local out: { [number]: Background, n: number } = { n = BACKGROUND_COUNT }
    for id = 0, BACKGROUND_COUNT - 1 do
        local b = backgrounds.picture(rom, rom:u32(loads + 4 * id))
        if b ~= nil then
            local callback = bit32.band(rom:u32(scrolls + 16 * id + 4), 0xFFFFFFFE)
            b.scroll = SCROLLERS[callback] or { 0, 0 }
            b.anims = gfx.anims(rom, rom:u32(anim_lists + 4 * id), PALETTE_BUFFER)
            out[id] = b
        end
    end
    return out
end

return stage
