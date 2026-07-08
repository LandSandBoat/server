-----------------------------------
-- Area: Abyssea - Tahrongi
--   NM: Glavoid
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    if player then
        player:addTitle(xi.title.GLAVOID_STAMPEDER)
    end
end

return entity
