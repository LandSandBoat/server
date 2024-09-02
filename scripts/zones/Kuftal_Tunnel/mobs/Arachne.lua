-----------------------------------
-- Area: Kuftal Tunnel
--   NM: Arachne
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 420)
end

return entity
