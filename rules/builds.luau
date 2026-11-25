--!strict
-- EXE6's builds: what a tool that makes and edits a player's side as a build reads of the game, as data (nettai-match's
-- `build`, for nettai's build screens). The simulation reads none of it. A definition is named by its id, a fact by
-- its setup field's name (../init.luau's `setup`).

return {
    -- The versions, as groups (docs/design/versions.md §2.2): what a save of each can own that the other's can't,
    -- in the order every list shows them, Gregar then Falzar. A build is of no version: it states what it has (its
    -- Crosses, of either version, its Cybeast, its folder), and a ruleset says whether it must be one version's. A
    -- group's members are the definitions whose own `version` names it (its Crosses and Beast forms, its Giga chips:
    -- ./folder) and the Bass-Cross MegaMan card's variant of its name (../patch_cards/bass-cross-megaman). A new
    -- build starts from a group: the forms MegaMan's facts offer of its version (its five Crosses, its Cybeast).
    -- A group's `color` (0xRRGGBB) is the color a tool draws it in: Gregar's green, Falzar's red. Its name is the
    -- locales' ([builds], `version.<id>`).
    groups = {
        { id = "gregar", color = 0x45E0A0 },
        { id = "falzar", color = 0xFF5D50 },
    },
    -- A build's other choices, each of a few presets that set their facts together, the first a new build's. EXE6's
    -- one is MegaMan's, which a tool offers as navis of their own, a card each among the game's (`cards`; the user:
    -- "add fbeast and gbeast as navi selection options since they were also available in beast link gate right?
    -- also megaman as his link navi form"): MegaMan; GBeast and FBeast, MegaMan in his Cybeast from the battle's
    -- start for good (`beast_start`, with that Cybeast: the Japanese Beast Link Gate's MegaMan Beast Outs at will
    -- and never goes Beast Over), with Beast Out off (`beast_out`, event flag 0xE0: the emotion window's empty box
    -- for the turns he never spends, and no Beast Out button he could never press, as a save without it has them);
    -- and the LinkNavi MegaMan, received from a navi code at its last level (the
    -- Japanese Navi Change Box's: his NaviCust and his level's gains, his Crosses, no Beast Out and no patch card
    -- applied). A preset is told apart by what it sets: a fact of the choice's that a preset leaves out is at the
    -- rules' default on it (no level on MegaMan, no `beast_start` on the LinkNavi). Its names are the locales'
    -- ([builds], `megaman.<id>`), its face the form it sets, if any.
    choices = {
        {
            id = "megaman",
            navi = "megaman",
            cards = true,
            presets = {
                { id = "megaman", set = {} },
                { id = "gregar_beast", set = { beast_start = true, beast_out = false, cybeast = "gregar_beast" } },
                { id = "falzar_beast", set = { beast_start = true, beast_out = false, cybeast = "falzar_beast" } },
                { id = "link_navi", set = { level = 14 } },
            },
        },
    },
    -- The facts a build never states: every build plays at the most the game allows, so these are always the rules'
    -- defaults (the most HP and Regular memory, the sun, a link navi's last level, every SP navi deleted in no time;
    -- MegaMan's level the choice above's).
    at_defaults = { hp = true, reg_up = true, sun = true, level = true, sp_times = true },
    -- A new build is its group's forms and the choice's first preset (MegaMan), with this.
    new = {
        -- What a new build states besides its group's forms: the most BugFrags a save holds, which the dark chips'
        -- parts spend (Tango's four EXE6 netplay saves hold 9999, the word at their image's 0x1BE0).
        set = { bug_frags = 9999 },
        -- The folder a new save starts with: the first folder of the ROM's folder table, which the new game routine
        -- copies into the save's first folder (US Falzar's table `byte_80213AC`, copied by `sub_8021AB4` from
        -- `reqBBS_init_8004DF0`, which the title screen's NEW GAME runs; the Japanese ROMs' table is at 0x080217C0).
        -- The four ROMs' tables are the same, so a new save's folder is one for both versions.
        folder = {
            { chip = "cannon", code = "A" },
            { chip = "cannon", code = "A" },
            { chip = "cannon", code = "B" },
            { chip = "cannon", code = "B" },
            { chip = "air_shot", code = "*" },
            { chip = "air_shot", code = "*" },
            { chip = "vulcan_1", code = "D" },
            { chip = "vulcan_1", code = "D" },
            { chip = "vulcan_1", code = "D" },
            { chip = "mini_bomb", code = "B" },
            { chip = "mini_bomb", code = "B" },
            { chip = "mini_bomb", code = "L" },
            { chip = "mini_bomb", code = "L" },
            { chip = "sword", code = "S" },
            { chip = "sword", code = "S" },
            { chip = "sword", code = "S" },
            { chip = "sword", code = "S" },
            { chip = "wide_sword", code = "S" },
            { chip = "wide_sword", code = "S" },
            { chip = "buster_up", code = "*" },
            { chip = "crack_shot", code = "*" },
            { chip = "crack_shot", code = "*" },
            { chip = "recovery_10", code = "A" },
            { chip = "recovery_10", code = "A" },
            { chip = "recovery_10", code = "L" },
            { chip = "recovery_10", code = "L" },
            { chip = "area_grab", code = "S" },
            { chip = "attack_10", code = "*" },
            { chip = "attack_10", code = "*" },
            { chip = "white_capsule", code = "*" },
        },
    },
}
