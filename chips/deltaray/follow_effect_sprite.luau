--!strict
-- The follow-effect sprite: its animations, each its frames' durations in ticks.
return asset.sprite("follow-effect", {
    { 1, 2, 2, 1 },
    { 2, 2, 2, loop = true },
})
