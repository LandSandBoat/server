-----------------------------------
-- Area: Den of Rancor
--   NM: Ogama
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 398)
end

return entity
