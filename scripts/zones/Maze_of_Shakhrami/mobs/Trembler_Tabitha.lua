-----------------------------------
-- Area: Maze of Shakhrami
--   NM: Trembler Tabitha
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 293)
    xi.magian.onMobDeath(mob, player, optParams, set{ 943 })
end

return entity
