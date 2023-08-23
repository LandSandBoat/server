-----------------------------------
-- Area: Quicksand Caves
--   NM: Nussknacker
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 435)
end

return entity
