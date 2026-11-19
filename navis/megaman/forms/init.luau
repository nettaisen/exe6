--!strict
-- EXE6's forms (docs/design/content-model-v2.md §4.0), by id: the tables of the modules that define them as one, which
-- the game's init.luau returns as its `forms`. Written by tools/content/index.py (the verification workspace) from the
-- modules that are there: run it again rather than edit this, also to settle a merge conflict in it.

local merge = require("@exelib/merge")

return merge {
    -- Forms.
    require("@self/aqua_cross"),
    require("@self/aqua_cross_beast"),
    require("@self/base"),
    require("@self/charge_cross"),
    require("@self/charge_cross_beast"),
    require("@self/dust_cross"),
    require("@self/dust_cross_beast"),
    require("@self/elec_cross"),
    require("@self/elec_cross_beast"),
    require("@self/erase_cross"),
    require("@self/erase_cross_beast"),
    require("@self/falzar_beast"),
    require("@self/falzar_beast_over"),
    require("@self/gregar_beast"),
    require("@self/gregar_beast_over"),
    require("@self/ground_cross"),
    require("@self/ground_cross_beast"),
    require("@self/heat_cross"),
    require("@self/heat_cross_beast"),
    require("@self/slash_cross"),
    require("@self/slash_cross_beast"),
    require("@self/tengu_cross"),
    require("@self/tengu_cross_beast"),
    require("@self/tomahawk_cross"),
    require("@self/tomahawk_cross_beast"),
}
