-----------------------------------
-- Area: Pashhow Marshlands [S]
--   NM: Croque-mitaine
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 506)
end

return entity
