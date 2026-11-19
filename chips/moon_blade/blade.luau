--!strict
-- MoonBld's blade (attack object #0x85, `sub_80D5C48`): the shared blade
-- (@exelib/moon_blade/blade) with EXE6's sprite and collision types. It rides
-- on its owner and sweeps the eight panels around it, one a tick for 8
-- ticks, starting ahead and going round, then goes after 10 ticks.

local collision = require("../../rules/collision")
local common = require("@exelib/moon_blade/blade")
local moon_blade_sprite = asset.sprite("moon_blade")

local blade = {}

blade.kind = common.make_kind("moon_blade/blade", {
    sprite = moon_blade_sprite,
    is = collision.slash,
    hits = collision.hits_navis,
})

-- `sub_80D5D34`: a blade on `owner` (`plain`: a plain blade's hits), its
-- panel and position the spawner's registers (`routine`: the address of the
-- phase routine spawning it; see @exelib/moon_blade/blade).
function blade.spawn(owner: Object, panel_x: number, routine: number, damage: number, plain: boolean): Object?
    return common.spawn(blade.kind, owner, panel_x, routine, damage, plain)
end

return blade
