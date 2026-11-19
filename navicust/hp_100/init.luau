--!strict
-- The NaviCust program HP+100 (program 42), in white, pink, blue.

local programs = require("../rules/navicust/programs")

local program: NaviCustProgram = {
    colors = { "white", "pink", "blue" },
    plus = true,
    shape = {
        ".......",
        ".......",
        "...##..",
        "...##..",
        ".......",
        ".......",
        ".......",
    },
    bug = "hp",
    effects = { programs.hp(100) },
}

return { hp_100 = program }
