--!strict
-- The dustman-portrait sprite: its animations, each its frames' durations in ticks.
return asset.sprite("dustman-portrait", {
    { 6 },
    { 2 },
    { 8, 7, 8, 7, 8, 7, 8, 7, loop = true },
})
