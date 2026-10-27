--!strict
-- The air-raid-plane sprite: its animations, each its frames' durations in ticks, and where its part 1 sits
-- in each frame (by animation, then frame: { x, y } from the object, unflipped).
return asset.sprite("air-raid-plane", {
    { 6, loop = true },
    { 8, 2, 2, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4 },
    { 1, 1, 1, 2, 2, 1, 1, 1, 2, 2, loop = true },
    { 4, 4 },
}, {
    parts = {
        [1] = {
            { { 18, -20 } },
            {
                { 18, -20 }, { 18, -20 }, { 18, -20 }, { 18, -20 }, { 18, -20 }, { 18, -20 }, { 18, -20 },
                { 18, -20 }, { 18, -20 }, { 18, -20 }, { 18, -20 }, { 18, -20 }, { 18, -20 },
            },
            {
                { 18, -20 }, { 17, -20 }, { 14, -20 }, { 18, -20 }, { 18, -20 }, { 18, -20 }, { 17, -20 },
                { 14, -20 }, { 18, -20 }, { 18, -20 },
            },
            { { 18, -20 }, { 18, -20 } },
        },
    },
})
