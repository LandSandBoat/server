-----------------------------------
-- Area: Quicksand Caves
--   NM: Sabotender Bailarin
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 433)
end

return entity
