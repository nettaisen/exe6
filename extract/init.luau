--!strict
-- EXE6's extraction recipe (docs/design/extraction-recipes.md): how its pack's assets are extracted from a complete
-- Legacy Collection's four ROMs (its `roms`). It reads the ROMs through the primitives (content/nettai/extract.d.luau)
-- and returns the asset model, which the host finishes. The game's root gives it as its `extract` (init.luau), so it
-- loads with the content.
--
-- What the four ROMs have alike is read from the Falzar US ROM (BR6E), a version's own from its US ROM
-- (versions.luau), the Japanese words from the Japanese ROMs (lettering.luau), and what the US release cut from the
-- Japanese ones (jp.luau).

local names = require("@self/names")
local hud = require("@self/hud")
local custom = require("@self/custom")
local lettering = require("@self/lettering")
local sprites = require("@self/sprites")
local stage = require("@self/stage")

local recipe: Recipe = {
    -- Every ROM of a complete Legacy Collection, each required, in the order its places read an address by (a
    -- ROM's slot): Falzar's US ROM, Gregar's, then their Japanese ones.
    roms = { "BR6E", "BR5E", "BR6J", "BR5J" },
    extract = function(set: Set): Extracted
        local n = names()
        local h = hud.hud(set, n)
        local c = custom.custom(set, n)
        -- The US ROMs' words are English; the Japanese ROMs' lettering is the pack's Japanese.
        h.languages = { { name = lettering.LANGUAGE, value = lettering.hud(set, h, n) } }
        h.language = "en"
        c.languages = { { name = lettering.LANGUAGE, value = lettering.custom(set) } }
        return {
            names = n,
            graphics = {
                sprites = sprites.sprites(set, n),
                field = stage.field(set.BR6E),
                backgrounds = stage.backgrounds(set.BR6E),
                hud = h,
                custom = c,
            },
            sound = { from = set.BR6E },
        }
    end,
}

return recipe
