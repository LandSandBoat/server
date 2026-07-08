-----------------------------------
-- Area: Promyvion-Mea
--   NM: Stray
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    xi.promyvion.emptyOnMobSpawn(mob, xi.promyvion.mobType.STRAY)
end

return entity
