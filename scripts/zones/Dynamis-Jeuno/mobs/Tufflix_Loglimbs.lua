-----------------------------------
-- Area: Dynamis - Jeuno
--  Mob: Tufflix Loglimbs
-----------------------------------
mixins =
{
    require('scripts/mixins/dynamis_beastmen'),
    require('scripts/mixins/job_special')
}
-----------------------------------
local ID = zones[xi.zone.DYNAMIS_JEUNO]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  12.244, y =  1.999, z = -4.306 }
}

entity.phList =
{
    [ID.mob.TUFFLIX_LOGLIMBS - 2] = ID.mob.TUFFLIX_LOGLIMBS, -- Vanguard_Armorer      15.499   8.384   -36.562
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
