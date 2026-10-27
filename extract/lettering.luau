--!strict
-- The Japanese ROMs' lettering (`ROCKEXE6_RXXBR6J`, `ROCKEXE6_GXXBR5J`): the pack's Japanese, beside the US ROMs'
-- English. The same code reaches each block as in the US ROMs (the HUD's and the custom screen's places), and both
-- Japanese ROMs have the same words but for the forms' names, which are each version's own.

local place = require("@exelib/extract/place")
local hud = require("./hud")
local custom = require("./custom")

local at = place.at

local lettering = {}

-- The pack's name for the Japanese ROMs' language.
lettering.LANGUAGE = "ja"

-- The Japanese ROMs' notice of the other player customizing, on the HUD layer: fourteen tiles, for the US ROMs'
-- sixteen.
local WAITING_BYTES = 0x1C0

-- Whether two banners are one: their place, kind, glyphs and number's place.
local function same_banner(a: BannerLayout, b: BannerLayout): boolean
    local na, nb = a.number_at, b.number_at
    local numbers = if na == nil or nb == nil then na == nb else na[1] == nb[1] and na[2] == nb[2]
    return a.x == b.x and a.y == b.y and a.kind == b.kind and a.glyphs == b.glyphs and numbers
end

-- The HUD's Japanese words, from the Japanese Falzar ROM. A banner is kept where it isn't the base's (`base`: the
-- pack's own words, a US ROM's); one of another kind than the base's is an error.
function lettering.hud(set: Set, base: Hud, names: AssetNames): HudLettering
    local rom = set.BR6J
    local languages: { [string]: { glyphs: { string }?, dialogue_glyphs: { string }? } } = names.language_glyphs or {}
    local glyphs = languages[lettering.LANGUAGE]
    local cell: { string } = if glyphs and glyphs.glyphs then glyphs.glyphs else {}
    local dialogue: { string } = if glyphs and glyphs.dialogue_glyphs then glyphs.dialogue_glyphs else {}
    local own_banners = base.banners or {}
    local banners: { [number]: BannerLayout, n: number } = { n = #own_banners }
    for i, own in own_banners do
        local id = i - 1
        local b = hud.banner(rom, id)
        local bg, og = b.glyphs, own.glyphs
        local same_glyphs = (if bg then bg:count() else 0) == (if og then og:count() else 0)
        local na, nb = b.number_at, own.number_at
        local same_number = if na == nil or nb == nil then na == nb else na[1] == nb[1] and na[2] == nb[2]
        if b.kind ~= own.kind or not same_number or not same_glyphs then
            error(string.format("the Japanese ROM's banner 0x%02x is another kind", 4 * id), 0)
        end
        if not same_banner(b, own) then
            banners[id] = b
        end
    end
    return {
        font = gba.tiles(rom, at(rom, hud.FONT), 0x40 * hud.FONT_GLYPHS),
        font_chars = hud.font_chars(cell),
        dialogue_font = hud.dialogue_font(rom, cell, dialogue),
        texts = hud.texts(rom),
        banners = banners,
        banner_palette = hud.palette(rom, at(rom, hud.BANNER_PALETTE)),
        waiting = gba.tiles(rom, at(rom, hud.WAITING), WAITING_BYTES),
        waiting_palette = hud.palette(rom, at(rom, hud.BANNER_PALETTE)),
        gauge_tiles = gba.tiles(rom, at(rom, hud.GAUGE_TILES), hud.GAUGE_BYTES),
    }
end

-- The custom screen's Japanese words: the chip window's pictures from the Japanese Falzar ROM, each version's forms'
-- names from its own Japanese ROM.
function lettering.custom(set: Set): CustomLettering
    local rom = set.BR6J
    local ok = custom.picture(rom, custom.OK)
    local ok_picked = custom.picture(rom, custom.OK_PICKED)
    local other = custom.picture(rom, custom.OTHER)
    local falzar = custom.tiles(set.BR6J, custom.FORM_NAMES)
    local gregar = custom.tiles(set.BR5J, custom.FORM_NAMES)
    local redeal = custom.picture(rom, custom.REDEAL)
    local scrap = custom.picture(rom, custom.SCRAP)
    return {
        pictures = { ok = ok, ok_picked = ok_picked, other = other },
        form_names = { { name = "falzar", value = falzar }, { name = "gregar", value = gregar } },
        buttons = {
            { name = custom.REDEAL_BUTTON, value = { picture = redeal } },
            { name = custom.SCRAP_BUTTON, value = { picture = scrap } },
        },
    }
end

return lettering
