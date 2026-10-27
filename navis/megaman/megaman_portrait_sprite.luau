--!strict
-- The megaman-portrait sprite: its animations, each its frames' durations in ticks.
return asset.sprite("megaman-portrait", {
    { 6 },
    { 40, 1, 5, 2, 100, 1, 5, 2, loop = true },
    { 7, 6, 7, 7, 7, 7, 7, 8, loop = true },
})
