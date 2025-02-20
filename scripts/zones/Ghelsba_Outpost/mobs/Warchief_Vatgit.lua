-----------------------------------
-- Area: Ghelsba Outpost
--  Mob: Warchief Vatgit
-- Involved in Mission 2-3
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.WARCHIEF_WRECKER)
end

return entity
