--!strict
-- The bubble sprite: its animations, each its frames' durations in ticks.
return asset.sprite("bubble", {
    { 6, 6, 4, 7, 6, 6, 4, 7, loop = true },
    { 1, 1, 1, 2 },
    { 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, loop = true },
    { 1, 1, 1, 2 },
})
