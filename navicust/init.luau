--!strict
-- EXE6's navicust programs (docs/design/content-model-v2.md §4.0), by id: the tables of the modules that define them
-- as one, which the game's init.luau returns as its `navicust_programs`. Written by tools/content/index.py (the
-- verification workspace) from the modules that are there: run it again rather than edit this, also to settle a merge
-- conflict in it.

local merge = require("@exelib/merge")

return merge {
    -- NaviCust programs.
    require("@self/air_shoes"),
    require("@self/anti_damage"),
    require("@self/attack_1"),
    require("@self/attack_max"),
    require("@self/auto_heal"),
    require("@self/battery"),
    require("@self/beat"),
    require("@self/body_pack"),
    require("@self/bug_stop"),
    require("@self/buster_pack"),
    require("@self/charge_1"),
    require("@self/charge_max"),
    require("@self/chip_shuffle"),
    require("@self/collect"),
    require("@self/custom_1"),
    require("@self/custom_2"),
    require("@self/first_barrier"),
    require("@self/fish"),
    require("@self/float_shoes"),
    require("@self/folder_pack_1"),
    require("@self/folder_pack_2"),
    require("@self/giga_folder_1"),
    require("@self/hp_100"),
    require("@self/hp_200"),
    require("@self/hp_300"),
    require("@self/hp_400"),
    require("@self/hp_50"),
    require("@self/hp_500"),
    require("@self/humor"),
    require("@self/jungle"),
    require("@self/mega_folder_1"),
    require("@self/mega_folder_2"),
    require("@self/millions"),
    require("@self/number_open"),
    require("@self/oil_body"),
    require("@self/poem"),
    require("@self/reflect"),
    require("@self/rush"),
    require("@self/shield"),
    require("@self/slip_runner"),
    require("@self/sneak_run"),
    require("@self/speed_1"),
    require("@self/speed_max"),
    require("@self/super_armor"),
    require("@self/tango"),
    require("@self/undershirt"),
}
