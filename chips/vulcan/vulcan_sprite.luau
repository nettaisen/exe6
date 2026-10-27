--!strict
-- The vulcan sprite: its animations, each its frames' durations in ticks.
return asset.sprite("vulcan", {
    { 2, 3, 2 },
    { 3, 2, 3, 2, 3, 2, 3, 2, loop = true },
    { 2 },
})
