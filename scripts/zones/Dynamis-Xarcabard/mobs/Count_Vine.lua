-----------------------------------
-- Area: Dynamis - Xarcabard
--  Mob: Count Vine
-----------------------------------
mixins =
{
    require('scripts/mixins/dynamis_beastmen'),
    require('scripts/mixins/job_special')
}
-----------------------------------
local ID = zones[xi.zone.DYNAMIS_XARCABARD]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -40.975, y = -23.718, z = -95.814 }
}

entity.phList =
{
    [ID.mob.COUNT_VINE - 1] = ID.mob.COUNT_VINE, -- Kindred_Samurai
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
