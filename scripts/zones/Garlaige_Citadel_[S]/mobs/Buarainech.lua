-----------------------------------
-- Area: Garlaige Citadel [S]
--   NM: Buarainech
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 534)
end

return entity
