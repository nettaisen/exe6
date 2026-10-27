--!strict
-- The battle sprites and the portraits: the sprite list (`SpritePointersList`: per category, a table of sprite
-- archive entries, bit 31 LZ77 compressed), whose pointer (`off_8002724`) is at the same address in the four ROMs.

local place = require("@exelib/extract/place")
local lists = require("@exelib/extract/sprites")
local versions = require("./versions")
local jp = require("./jp")

local sprites = {}

local SPRITE_LIST = place.pointer(0x0800_2724, 0x0800_2724)
-- Categories with battle sprites (the byte offsets 0x00..=0x14) of the list's ten.
local BATTLE_CATEGORIES = 6
local CATEGORIES = 10

-- The portraits' category (`mugshotSpritePtrs`, byte offset 0x20) and its black placeholder (`mugshotBlack`), which
-- each US ROM has in place of the other game's link navis.
local PORTRAITS = 0x20
local BLACK_PORTRAIT = 7

-- The portraits content names (the chatbox's speakers), each from the ROM that has its true face: the Falzar US
-- ROM's unless it has the black placeholder there, then the Gregar one's, then the Japanese ones'. DustMan's is in the
-- Gregar ROMs too, where their table has the black one for it (versions.luau's `DUSTMAN_PORTRAIT`).
local function portraits(set: Set, names: AssetNames): { Sheet }
    local sources = { set.BR6E, set.BR5E, set.BR6J, set.BR5J }
    local indexes: { number } = {}
    for index in ((names.sprites or {})[PORTRAITS] or {}) do
        table.insert(indexes, index)
    end
    table.sort(indexes)
    local out: { Sheet } = {}
    for _, index in indexes do
        local sheet = lists.portrait(sources, SPRITE_LIST, PORTRAITS, index, BLACK_PORTRAIT)
        if sheet == nil and index == versions.DUSTMAN_PORTRAIT.index then
            local rom = set.BR5E
            local archive = sprite.archive(rom, place.at(rom, versions.DUSTMAN_PORTRAIT.place))
            if archive ~= nil then
                sheet = sprite.portrait(archive, PORTRAITS, index)
            end
        end
        if sheet ~= nil then
            table.insert(out, sheet)
        end
    end
    return out
end

-- The ROM a battle sprite's slot is read from: a Japanese one for the slots the US ROMs have a placeholder in
-- (jp.luau's `SPRITES`), a version's for the Cybeasts (versions.luau's `SPRITES`), else the Falzar US ROM. The
-- releases' sheets are the same but for those and the flames HeatMan wears (10-19), whose throw (animation 6) has
-- three frames of 5, 4 and 3 ticks in the US ROMs and four of 3 in the Japanese ones.
local function source(set: Set, category: number, index: number): Rom
    if jp.has_sprite(category, index) then
        return set.BR6J
    end
    for _, s in versions.SPRITES do
        if s.category == category and s.index == index then
            return versions.rom(set, s.version)
        end
    end
    return set.BR6E
end

-- The battle sprites and the named portraits.
function sprites.sprites(set: Set, names: AssetNames): { Sheet }
    local out = portraits(set, names)
    local rom = set.BR6E
    local categories = lists.categories(rom, place.at(rom, SPRITE_LIST), CATEGORIES)
    for k = 1, BATTLE_CATEGORIES do
        local category = (k - 1) * 4
        for index = 0, lists.slots(categories, k) - 1 do
            local own = source(set, category, index)
            local sheet = lists.sheet(own, lists.entry(own, SPRITE_LIST, category, index), category, index)
            if sheet ~= nil then
                table.insert(out, sheet)
            end
        end
    end
    return out
end

return sprites
