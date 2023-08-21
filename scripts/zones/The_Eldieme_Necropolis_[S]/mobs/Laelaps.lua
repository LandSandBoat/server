-----------------------------------
-- Area: The Eldieme Necropolis [S]
--   NM: Laelaps
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 495)
end

return entity
