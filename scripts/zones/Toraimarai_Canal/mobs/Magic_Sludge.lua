-----------------------------------
-- Area: Toraimarai Canal
--   NM: Magic Sludge
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    player:setCharVar("rootProblem", 3)
end

return entity
