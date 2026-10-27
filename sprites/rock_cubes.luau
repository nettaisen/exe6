--!strict
-- The rock-cubes sprite: its animations, each its frames' durations in ticks.
return asset.sprite("rock-cubes", {
    { 2, 2, 2, 2, 2 },
    { 2 },
    { 2 },
    { 10, 10, 10, 10, loop = true },
})
