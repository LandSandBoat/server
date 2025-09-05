-----------------------------------
-- Area: Dynamis - Xarcabard
--  Mob: Marquis Sabnak
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
    { x =  72.315, y = -24.214, z = -127.865 }
}

entity.phList =
{
    [ID.mob.MARQUIS_SABNAK - 1] = ID.mob.MARQUIS_SABNAK, -- Kindred_Paladin
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
