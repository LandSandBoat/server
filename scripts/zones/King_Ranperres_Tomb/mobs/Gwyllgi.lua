-----------------------------------
-- Area: King Ranperres Tomb
--   NM: Gwyllgi
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 177)
end

return entity
