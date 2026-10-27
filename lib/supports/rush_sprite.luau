--!strict
-- The rush sprite: its animations, each its frames' durations in ticks.
return asset.sprite("rush", {
    { 3, 4, 4, 5, 4, 4 },
    { 42, 3, 2, 3, 2, 3, 2, 8, loop = true },
    { 2, 3, 4, 2, 3, 3, 3 },
    { 3, 2, 3, loop = true },
})
