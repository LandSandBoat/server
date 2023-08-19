-----------------------------------
-- Area: The Eldieme Necropolis
--   NM: Skull of Gluttony
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 184)
end

return entity
