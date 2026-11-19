--!strict
-- The NaviCust program SneakRun (program 16), in white.

local programs = require("../rules/navicust/programs")

local program: NaviCustProgram = {
    colors = { "white" },
    shape = {
        ".......",
        ".......",
        "...#...",
        "..###..",
        "...#...",
        ".......",
        ".......",
    },
    compressed = {
        ".......",
        ".......",
        "...#...",
        "..###..",
        ".......",
        ".......",
        ".......",
    },
    bug = "encounter",
    effects = { programs.outside("sneak_run") },
}

return { sneak_run = program }
