-----------------------------------
-- Area: South Gustaberg
--   NM: Carnero
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 202)
end

return entity
