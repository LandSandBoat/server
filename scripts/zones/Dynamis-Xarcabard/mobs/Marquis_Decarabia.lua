-----------------------------------
-- Area: Dynamis - Xarcabard
--  Mob: Marquis Decarabia
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
    { x =  392.770, y = -0.649, z = -215.006 }
}

entity.phList =
{
    [ID.mob.MARQUIS_DECARABIA - 1] = ID.mob.MARQUIS_DECARABIA, -- Kindred_Bard
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
