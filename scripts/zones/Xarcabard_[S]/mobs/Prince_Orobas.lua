-----------------------------------
-- Area: Xarcabard [S]
--   NM: Prince Orobas
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 541)
end

return entity
