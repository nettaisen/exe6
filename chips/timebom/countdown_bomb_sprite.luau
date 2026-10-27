--!strict
-- The countdown-bomb sprite: its animations, each its frames' durations in ticks.
return asset.sprite("countdown-bomb", {
    { 3, 3, 3, 3, 3, 1 },
    { 1 },
    { 3, 3, 3, 3, 3, 1 },
    { 1 },
    { 2, 3, 3 },
    { 2, 3, 3 },
    { 4, 4, 2, 4, loop = true },
})
