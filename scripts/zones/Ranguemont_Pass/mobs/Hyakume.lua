-----------------------------------
-- Area: Ranguemont Pass
--   NM: Hyakume
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 344)
end

return entity
