-----------------------------------
-- Area: Korroloka Tunnel
--   NM: Thoon
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 229)
end

return entity
