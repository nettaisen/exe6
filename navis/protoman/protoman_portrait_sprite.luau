--!strict
-- The protoman-portrait sprite: its animations, each its frames' durations in ticks.
return asset.sprite("protoman-portrait", {
    { 6 },
    { 2 },
    { 8, 7, 8, 7, 8, 7, 8, 7, loop = true },
})
