-----------------------------------
-- Area: Misareaux Coast
--   NM: Odqan
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 443)
end

return entity
