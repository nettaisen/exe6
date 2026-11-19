--!strict
-- The NaviCust program OilBody (program 17), in red.

local programs = require("../rules/navicust/programs")

local program: NaviCustProgram = {
    colors = { "red" },
    shape = {
        ".......",
        ".......",
        "...#...",
        "...#...",
        "..###..",
        ".......",
        ".......",
    },
    compressed = {
        ".......",
        ".......",
        "...#...",
        "...#...",
        "..##...",
        ".......",
        ".......",
    },
    bug = "encounter",
    exclusive = "encounter_element",
    effects = { programs.outside("oil_body") },
}

return { oil_body = program }
