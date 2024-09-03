-----------------------------------
-- Area: Halvung
--   NM: Flammeri
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 467)
end

return entity
