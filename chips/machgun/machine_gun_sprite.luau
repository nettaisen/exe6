--!strict
-- The machine-gun sprite: its animations, each its frames' durations in ticks.
return asset.sprite("machine-gun", {
    { 1 },
    { 3, 2, 3, 2, loop = true },
})
