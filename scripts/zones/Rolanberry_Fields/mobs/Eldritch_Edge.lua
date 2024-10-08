-----------------------------------
-- Area: Rolanberry Fields
--   NM: Eldritch Edge
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 218)
end

return entity
