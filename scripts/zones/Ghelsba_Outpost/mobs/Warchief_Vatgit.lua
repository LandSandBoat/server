-----------------------------------
-- Area: Ghelsba Outpost
--  Mob: Warchief Vatgit
-- Involved in Mission 2-3
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    if player then
        player:addTitle(xi.title.WARCHIEF_WRECKER)
    end
end

return entity
