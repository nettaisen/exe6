--!strict
-- The moon-beam sprite: its animations, each its frames' durations in ticks.
return asset.sprite("moon-beam", {
    { 3, 4, 3, 4, 2 },
    { 2 },
    { 3, 3, loop = true },
    { 3, 3, 3, loop = true },
    { 3, 3, 3, loop = true },
})
