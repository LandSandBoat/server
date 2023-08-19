-----------------------------------
-- Area: Gustav Tunnel
--   NM: Ungur
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 475)
end

return entity
