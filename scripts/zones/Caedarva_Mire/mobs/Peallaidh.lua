-----------------------------------
-- Area: Caedarva Mire
--  Mob: Peallaidh
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 468)
end

return entity
