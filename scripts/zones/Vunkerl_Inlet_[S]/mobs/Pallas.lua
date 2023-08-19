-----------------------------------
-- Area: Vunkerl Inlet [S]
--   NM: Pallas
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 489)
end

return entity
