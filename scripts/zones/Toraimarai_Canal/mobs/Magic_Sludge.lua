-----------------------------------
-- Area: Toraimarai Canal
--   NM: Magic Sludge
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    player:setCharVar("rootProblem", 3)
end

return entity
