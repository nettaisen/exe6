--!strict
-- The instrument sprite: its animations, each its frames' durations in ticks.
return asset.sprite("instrument", {
    { 2 },
    { 2, 4, 3, 2, 2 },
    { 3, 3, 8 },
    { 3, 3, loop = true },
    { 6, 3, 3, 3, 2, 6, 3, 3, 3, 3, 3, 5, 3, 3, loop = true },
})
