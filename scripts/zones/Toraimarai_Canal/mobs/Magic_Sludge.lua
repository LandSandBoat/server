-----------------------------------
-- Area: Toraimarai Canal
--   NM: Magic Sludge
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    player:setCharVar("rootProblem", 3)
end

return entity
