--!strict
-- The beat sprite: its animations, each its frames' durations in ticks.
return asset.sprite("beat", {
    { 2 },
    { 4 },
    { 3, 2, 3, 2, loop = true },
    { 2, 2, 2, 2, loop = true },
    { 2, 3, 2 },
})
