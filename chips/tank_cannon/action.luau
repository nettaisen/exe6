--!strict
-- The TankCans' action (the original's action 0x24, `sub_80ECACA`;
-- docs/engine/shot-chips.md §7): the shared action
-- (@exelib/tank_cannon/action) with EXE6's tank cannon and shell (shell.luau).
-- The navi aims its tank cannon for 16 ticks, then fires a shell from the
-- panel ahead on the 23rd, the screen shaking; it lowers the cannon on the
-- 36th and is back to idle 4 ticks later.

local attachment = require("../../objects/attachment")
local common = require("@exelib/tank_cannon/action")
local shell = require("./shell")
local tank_cannon_sprite = asset.sprite("tank_cannon")

local tank_cannon = {}

-- One state for the three.
tank_cannon.STATE = common.STATE

-- The tank cannon (the original's attachment row 0x14).
local TANK = attachment.look { sprite = tank_cannon_sprite, palette = 0, attach_point = 8 }

-- A chip's tank cannon: the shell it fires.
function tank_cannon.action(spec: { shell: ShellSpec }): Action
    return common.action { cannon = TANK, attachment = attachment.kind, kind = shell.kind, shell = spec.shell }
end

return tank_cannon
