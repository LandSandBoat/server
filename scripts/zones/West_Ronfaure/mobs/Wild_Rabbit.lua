-----------------------------------
-- Area: West Ronfaure
--  Mob: Wild Rabbit
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
	-- Set respawn time in seconds
	mob:setRespawnTime(30)
end

return entity
