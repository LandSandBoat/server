-----------------------------------
-- Area: The Eldieme Necropolis
--   NM: Skull of Greed
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 185)
end

return entity
