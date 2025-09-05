-----------------------------------
-- Area: Western Altepa Desert
--  Mob: Phorusrhacos
-- Note: PH for Picolaton
-----------------------------------
local ID = zones[xi.zone.WESTERN_ALTEPA_DESERT]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -685.635, y =  -9.206, z = -701.860 },
    { x = -723.357, y = -19.170, z = -703.392 },
    { x = -748.385, y = -20.079, z = -649.150 },
    { x = -704.630, y =  -7.299, z = -604.633 },
    { x = -665.073, y =  -4.798, z = -592.440 },
    { x = -605.754, y =   0.102, z = -584.290 }
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    -- Picolaton PH has a varied spawn location
    if mob:getID() == (ID.mob.PICOLATON - 1) then
        xi.mob.updateNMSpawnPoint(mob)
    end

    xi.mob.phOnDespawn(mob, ID.mob.PICOLATON, 10, 6400)
end

return entity
