-----------------------------------
-- Area: North Gustaberg
--   NM: Stinging Sophie
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 197)
end

return entity
