-----------------------------------
-- Area: Halvung
--   NM: Copper Borer
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 465)
end

return entity
