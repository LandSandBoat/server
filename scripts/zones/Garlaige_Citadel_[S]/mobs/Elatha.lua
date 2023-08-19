-----------------------------------
-- Area: Garlaige Citadel [S]
--   NM: Elatha
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 535)
end

return entity
