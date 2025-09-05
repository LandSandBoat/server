-----------------------------------
-- Area: Dynamis - Jeuno
--  Mob: Mobpix Mucousmouth
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
    { x =  1.255, y =  2.486, z =  111.045 }
}

entity.phList =
{
    [ID.mob.MOBPIX_MUCOUSMOUTH - 3] = ID.mob.MOBPIX_MUCOUSMOUTH, -- Vanguard_Welldigger   -0.508   2.499   112.929
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
