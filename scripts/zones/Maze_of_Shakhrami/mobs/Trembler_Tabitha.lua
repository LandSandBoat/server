-----------------------------------
-- Area: Maze of Shakhrami
--   NM: Trembler Tabitha
-----------------------------------
local ID = zones[xi.zone.MAZE_OF_SHAKHRAMI]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.TREMBLER_TABITHA - 2] = ID.mob.TREMBLER_TABITHA,
    [ID.mob.TREMBLER_TABITHA - 1] = ID.mob.TREMBLER_TABITHA,
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 293)
    xi.magian.onMobDeath(mob, player, optParams, set{ 943 })
end

return entity
