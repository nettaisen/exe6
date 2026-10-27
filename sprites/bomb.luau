--!strict
-- The bomb sprite: its animations, each its frames' durations in ticks.
return asset.sprite("bomb", {
    { 5, 4 },
    { 1 },
    { 5, 4 },
    { 4, 4, 4, 4, 4, loop = true },
    { 5, 4 },
    { 1 },
    { 5, 4 },
    { 3, 3, 3, 3, loop = true },
    { 5, 4 },
    { 3, 3, 3, 3, loop = true },
})
