-----------------------------------
-- Area: Korroloka Tunnel
--   NM: Falcatus Aranei
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 227)
end

return entity
