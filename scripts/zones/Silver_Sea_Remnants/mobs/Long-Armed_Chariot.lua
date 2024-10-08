-----------------------------------
-- Area: Silver Sea Remnants
--   NM: Long-Armed Chariot
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.MOON_CHARIOTEER)
end

return entity
