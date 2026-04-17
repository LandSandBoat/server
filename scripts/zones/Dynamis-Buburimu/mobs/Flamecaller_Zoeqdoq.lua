-----------------------------------
-- Area: Dynamis - Buburimu
--  Mob: Flamecaller Zoeqdoq
-----------------------------------
mixins =
{
    require('scripts/mixins/dynamis_beastmen'),
    require('scripts/mixins/job_special')
}
-----------------------------------
local ID = zones[xi.zone.DYNAMIS_BUBURIMU]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -77.980, y = -16.500, z =  36.023 }
}

entity.phList =
{
    [ID.mob.FLAMECALLER_ZOEQDOQ - 12] = ID.mob.FLAMECALLER_ZOEQDOQ, -- Vanguard_Mesmerizer
}

entity.onMobSpawn = function(mob)
    xi.dynamis.mobInfo(mob)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
