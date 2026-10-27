--!strict
-- The col-army sprite: its animations, each its frames' durations in ticks.
return asset.sprite("col-army", {
    { 1, 3, 3, 3, 5, 3, 2 },
    { 2, 2, 2, loop = true },
    { 4, 3, 3, 3, 1 },
    { 2 },
})
