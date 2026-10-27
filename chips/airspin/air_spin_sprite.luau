--!strict
-- The air-spin sprite: its animations, each its frames' durations in ticks.
return asset.sprite("air-spin", {
    { 1, 2, 2 },
    { 2, 2, loop = true },
})
