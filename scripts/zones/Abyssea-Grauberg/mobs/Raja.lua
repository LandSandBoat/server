-----------------------------------
-- Area: Abyssea - Grauberg
--   NM: Raja
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    if player then
        player:addTitle(xi.title.RAJA_REGICIDE)
    end
end

return entity
