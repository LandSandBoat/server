-----------------------------------
-- Area: Dynamis - Xarcabard
--  Mob: Marquis Gamygyn
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
    { x = -72.227, y = -24.311, z = -79.561 }
}

entity.phList =
{
    [ID.mob.MARQUIS_GAMYGYN - 1] = ID.mob.MARQUIS_GAMYGYN, -- Kindred_Ninja
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
