--!strict
-- The tenguman-portrait sprite: its animations, each its frames' durations in ticks.
return asset.sprite("tenguman-portrait", {
    { 6 },
    { 40, 1, 5, 2, 100, 1, 5, 2, loop = true },
    { 7, 6, 7, 6, 7, 6, 7, 6, loop = true },
})
