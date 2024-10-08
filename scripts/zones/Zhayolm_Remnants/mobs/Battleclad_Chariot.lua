-----------------------------------
-- Area: Zhayolm Remnants
--   NM: Battleclad Chariot
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.STAR_CHARIOTEER)
end

return entity
