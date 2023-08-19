-----------------------------------
-- Area: Gustav Tunnel
--   NM: Amikiri
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 473)
end

return entity
