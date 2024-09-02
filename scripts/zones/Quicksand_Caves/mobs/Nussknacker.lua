-----------------------------------
-- Area: Quicksand Caves
--   NM: Nussknacker
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 435)
end

return entity
