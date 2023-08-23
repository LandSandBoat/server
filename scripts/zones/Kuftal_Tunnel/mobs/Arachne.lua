-----------------------------------
-- Area: Kuftal Tunnel
--   NM: Arachne
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 420)
end

return entity
