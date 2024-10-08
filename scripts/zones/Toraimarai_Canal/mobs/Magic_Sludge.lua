-----------------------------------
-- Area: Toraimarai Canal
--   NM: Magic Sludge
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    player:setCharVar('rootProblem', 3)
end

return entity
