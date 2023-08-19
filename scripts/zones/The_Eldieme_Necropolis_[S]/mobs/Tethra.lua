-----------------------------------
-- Area: The Eldieme Necropolis [S]
--   NM: Tethra
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 496)
end

return entity
