-----------------------------------
-- Area: South Gustaberg
--   NM: Bubbly Bernie
-- TODO: On retail he technically pops claimed but not aggressive, but we don't have a way to do that yet.
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = 758.276, y = -1.579, z = -688.066 },
    { x = 748.932, y = -2.708, z = -691.426 },
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 80, 2, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
end

return entity
