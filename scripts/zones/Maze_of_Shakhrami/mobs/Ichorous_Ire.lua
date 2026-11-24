-----------------------------------
-- Area: Maze of Shakhrami
--   NM: Ichorous Ire
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    mob:setLocalVar('cooldown', GetSystemTime() + utils.minutes(10))
end

return entity
