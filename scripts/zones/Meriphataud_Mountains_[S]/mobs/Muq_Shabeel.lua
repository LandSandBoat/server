-----------------------------------
-- Area: Meriphataud Mountains [S]
--   NM: Muq Shabeel
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 525)
end

return entity
