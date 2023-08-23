-----------------------------------
-- Area: Dangruf Wadi
--   NM: Teporingo
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 223)
end

return entity
