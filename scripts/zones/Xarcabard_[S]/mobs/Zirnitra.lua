-----------------------------------
-- Area: Xarcabard [S]
--   NM: Zirnitra
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 543)
end

return entity
