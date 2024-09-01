-----------------------------------
-- Area: Quicksand Caves
--   NM: Diamond Daig
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 428)
end

return entity
