-----------------------------------
-- Area: The Eldieme Necropolis
--   NM: Skull of Gluttony
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 184)
end

return entity
