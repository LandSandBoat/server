-----------------------------------
-- Area: Dynamis - Xarcabard
--  Mob: Duke Gomory
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
    { x =  138.420, y = -25.042, z = -175.906 }
}

entity.phList =
{
    [ID.mob.DUKE_GOMORY - 1] = ID.mob.DUKE_GOMORY, -- Kindred_Monk
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
