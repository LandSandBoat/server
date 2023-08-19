-----------------------------------
-- Area: Xarcabard [S]
--   NM: Prince Orobas
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 541)
end

return entity
