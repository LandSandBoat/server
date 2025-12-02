-----------------------------------
-- Area: Dynamis - Xarcabard
--  Mob: Duke Scox
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
    { x =  17.611, y = -23.619, z = -121.383 }
}

entity.phList =
{
    [ID.mob.DUKE_SCOX + 10] = ID.mob.DUKE_SCOX, -- Kindred_Dark_Knight
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
