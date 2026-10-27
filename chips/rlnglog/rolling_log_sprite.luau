--!strict
-- The rolling-log sprite: its animations, each its frames' durations in ticks.
return asset.sprite("rolling-log", {
    { 3 },
    { 3, 3, 3, 3, loop = true },
    { 3 },
    { 3, 3, 3, 3, loop = true },
})
