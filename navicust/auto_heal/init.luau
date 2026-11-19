--!strict
-- The NaviCust program AutoHeal (program 26), in pink.

local programs = require("../rules/navicust/programs")

local program: NaviCustProgram = {
    colors = { "pink" },
    shape = {
        ".......",
        "...#...",
        "...#...",
        "...#...",
        ".###...",
        ".......",
        ".......",
    },
    compressed = {
        ".......",
        ".......",
        "...#...",
        "...#...",
        ".###...",
        ".......",
        ".......",
    },
    bug = "panel",
    effects = { programs.outside("auto_heal") },
}

return { auto_heal = program }
