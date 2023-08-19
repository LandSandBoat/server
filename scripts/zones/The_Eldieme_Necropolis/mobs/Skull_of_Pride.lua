-----------------------------------
-- Area: The Eldieme Necropolis
--   NM: Skull of Pride
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 188)
end

return entity
