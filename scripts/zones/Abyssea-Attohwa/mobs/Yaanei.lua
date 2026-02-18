-----------------------------------
-- Area: Abyssea - Attohwa
--   NM: Yaanei
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    if player then
        player:addTitle(xi.title.YAANEI_CRASHER)
    end
end

return entity
