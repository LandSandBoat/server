-----------------------------------
-- Area: Halvung
--   NM: Flammeri
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 467)
end

return entity
