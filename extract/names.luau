--!strict
-- The names EXE6's pack's assets are written under (docs/design/extraction-recipes.md §4.3), from compat: assets.toml
-- by number, a chip's icon and picture by its key in chips.toml (`cannon`), a navi's emblem by its key in navis.toml
-- (`heatman`), what each glyph of the fonts draws (text.toml; the Japanese ROMs' encoding is the pack's Japanese
-- lettering's). The numbers each name belongs to are checked as the compat crate checks them.

local names = require("@exelib/extract/names")

-- The language of the Japanese ROMs' words, as the pack names its lettering.
local JAPANESE = "ja"

return function(): AssetNames
    local assets = data("compat/assets.toml")
    local chips = data("compat/chips.toml")
    local navis = data("compat/navis.toml")
    local text = data("compat/text.toml")
    names.unique("chips.toml", chips, function(c: any): any
        return c.id
    end)
    names.unique("navis.toml", navis, function(n: any): any
        return n.navi
    end)
    names.unique("assets.toml: sprites", assets.sprites)
    names.unique("assets.toml: sounds", assets.sounds)
    names.unique("assets.toml: backgrounds", assets.backgrounds)
    names.unique("assets.toml: banners", assets.banners)
    names.unique("assets.toml: mugshots", assets.mugshots)
    local chip_keys: { [number]: string } = {}
    for _, key in names.sorted(chips) do
        chip_keys[chips[key].id] = names.key(key)
    end
    local navi_keys: { [number]: string } = {}
    for _, key in names.sorted(navis) do
        navi_keys[navis[key].navi] = names.key(key)
    end
    return {
        sprites = names.sprites(assets.sprites),
        songs = names.by_number(assets.sounds),
        backgrounds = names.by_number(assets.backgrounds),
        mugshots = names.by_number(assets.mugshots),
        banners = names.by_number(assets.banners),
        chips = chip_keys,
        navis = navi_keys,
        glyphs = text.glyphs,
        dialogue_glyphs = text.dialogue_glyphs or {},
        language_glyphs = { [JAPANESE] = { glyphs = text.jp.glyphs, dialogue_glyphs = text.jp.dialogue_glyphs or {} } },
    }
end
