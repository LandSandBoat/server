-----------------------------------
-- Area: Gustav Tunnel
--   NM: Taxim
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 424)
end

return entity
