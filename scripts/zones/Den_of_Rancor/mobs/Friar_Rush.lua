-----------------------------------
-- Area: Den of Rancor
--   NM: Friar Rush
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 394)
end

return entity
