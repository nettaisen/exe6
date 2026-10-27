--!strict
-- What is a version's own, which the pack takes from a ROM of that version (its US ROM, `MEGAMAN6_FXXBR6E` or
-- `MEGAMAN6_GXXBR5E`). The same code reaches them in every ROM, so the places are the other modules'; here is which
-- of them are a version's.
--
-- - A version's own faces: a ROM has none for the other version's Crosses, its Beast and its link navis (its tables
--   show its own counterpart's). The pack has the Gregar ROMs' as faces of their own, numbered after the Falzar
--   ROMs', and Gregar's forms and navis name them: every form shows its true face, on either console.
-- - Gregar's five Giga chips' pictures and icons. Each US ROM draws its own version's five and has them again at the
--   other version's (Bass and BassAnly, BigHook and MetrKnuk, DeltaRay and CrossDiv, ColForce and HubBatc, BugRSwrd
--   and BgDthThd share one picture, palette and icon in each ROM): the pack has each chip's from its own version's
--   ROM, on either console, marked with that version (`chip_version`).
-- - What a console shows of its own version on the custom screen (the custom screen's versioned pictures,
--   custom.luau's `version_pictures`).
-- - The Cybeasts' sprites (`SPRITES`): a ROM has its own version's and a placeholder archive in the other's slot.
-- - One portrait the Gregar ROMs hold of a Falzar navi, DustMan's, that their table doesn't point at
--   (`DUSTMAN_PORTRAIT`).

local place = require("@exelib/extract/place")

local versions = {}

-- The versions, as the pack has what is a version's own under (its base version first).
versions.FALZAR = "falzar"
versions.GREGAR = "gregar"

-- Each version's US ROM: the pack has a version's own from it.
function versions.rom(set: Set, version: string): Rom
    return if version == versions.GREGAR then set.BR5E else set.BR6E
end

-- The chips whose picture and icon the Falzar ROM has wrong and the Gregar ROM right: Bass, BigHook, DeltaRay,
-- ColForce, BugRSwrd (their records' +0x20 icon, +0x24 picture and +0x28 palette); and their counterparts, which the
-- Falzar ROM has right and the Gregar ROM wrong: BassAnly, MetrKnuk, CrossDiv, HubBatc, BgDthThd.
local RIGHT_IN_GREGAR = { first = 0x12D, last = 0x131 }
local RIGHT_IN_FALZAR = { first = 0x132, last = 0x136 }

-- The emotion window's pictures a version has its own of (`off_801CD08`'s 5 to 0x16: its Crosses, tired, in Beast
-- Out, its Beast, Full Synchro and Beast Over; the five before them are MegaMan's own, the same in every ROM). The
-- pack numbers Gregar's after the Falzar ROMs' 23, from 0x17 (compat/assets.toml names them).
versions.OWN_FACES = { first = 5, last = 0x16 }

-- How many of the link navis' faces (`sub_801CC34`'s table) are a version's own: the first five (Gregar's HeatMan,
-- ElecMan, SlashMan, EraseMan, ChargeMan); the sixth is the same in every ROM. The pack numbers Gregar's after the
-- Falzar ROMs' six.
versions.OWN_NAVI_FACES = 5

-- The sprite slots (category's byte offset, index) only one version's ROMs fill, the other's holding the placeholder
-- archive there (the one the US ROMs have in jp.luau's `SPRITES`' slots): the Cybeasts, Gregar and Falzar. The pack
-- has each from a ROM of its version.
versions.SPRITES = {
    { category = 0x08, index = 0x14, version = versions.GREGAR },
    { category = 0x08, index = 0x15, version = versions.FALZAR },
}

-- DustMan's portrait (the portraits' index 0x4E) in the Gregar ROMs. Its archive is there, after SlashMan's, though
-- DustMan is Falzar's and the Gregar ROMs have none of Falzar's other four link navis' portraits; no entry of the
-- portraits' table points at it (theirs for DustMan is the black one), and an archive doesn't say where it ends, so
-- the place can't be reckoned from the one before. It is stated: the US Gregar ROM's and the Japanese one's.
versions.DUSTMAN_PORTRAIT = { index = 0x4E, place = place.stated({ 0, 0x084F_2AE8, 0, 0x0850_2254 }) }

-- The version chip `id` belongs to, whose ROMs alone have its picture and icon (the library flag of its record,
-- +0x09's 0x40, is set there); none for a chip of both.
function versions.chip_version(id: number): string?
    if id >= RIGHT_IN_GREGAR.first and id <= RIGHT_IN_GREGAR.last then
        return versions.GREGAR
    elseif id >= RIGHT_IN_FALZAR.first and id <= RIGHT_IN_FALZAR.last then
        return versions.FALZAR
    end
    return nil
end

-- The Falzar chip, whose icon the Falzar ROMs alone have: the Gregar ROMs' record has a placeholder that reads "13A".
-- (The Gregar chip's icon is in all four.)
local FALZAR_CHIP = 0x139

-- The ROM chip `id`'s record is read from: one of its own version (the pack has the US games' art where the
-- releases differ; the Japanese ROMs' pictures of the chips the US ROMs have none of are jp.luau's). A chip of both
-- is the same in every ROM but for the BeastOut chip's picture, which is the version's Beast Out button's: the pack
-- has the Falzar ROMs', its base version's.
function versions.chip_source(set: Set, id: number): Rom
    local version = versions.chip_version(id)
    return versions.rom(set, version or versions.FALZAR)
end

-- The ROM chip `id`'s icon is read from: its record's (`chip_source`), but the Falzar chip's, which is a Falzar
-- ROM's alone.
function versions.icon_source(set: Set, id: number): Rom
    if id == FALZAR_CHIP then
        return set.BR6E
    end
    return versions.chip_source(set, id)
end

return versions
