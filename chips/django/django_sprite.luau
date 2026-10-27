--!strict
-- The django sprite: its animations, each its frames' durations in ticks.
return asset.sprite("django", {
    { 2 },
    { 2, 2 },
    { 2, 2 },
    { 2, 3, 3 },
    { 2, 2, loop = true },
    { 8, 2, 2, 3, 4 },
    { 2, 2, 2, 2, loop = true },
    { 2, 2, loop = true },
    { 2, 3, 3 },
    { 2, 2, loop = true },
})
