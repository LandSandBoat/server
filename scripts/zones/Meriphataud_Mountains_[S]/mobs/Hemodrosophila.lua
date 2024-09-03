-----------------------------------
-- Area: Meriphataud Mountains [S]
--   NM: Hemodrosophila
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 527)
end

return entity
