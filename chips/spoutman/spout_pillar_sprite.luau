--!strict
-- The spout-pillar sprite: its animations, each its frames' durations in ticks.
return asset.sprite("spout-pillar", {
    { 1, 5, 4 },
    { 4, 4, 4, 4, 3, 3, 2, 4 },
    { 4, 4, loop = true },
    { 2 },
})
