-----------------------------------
-- Area: The Boyahda Tree
--   NM: Leshonki
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 360)
end

return entity
