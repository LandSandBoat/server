-----------------------------------
-- Area: Quicksand Caves
--   NM: Diamond Daig
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 428)
end

return entity
