-----------------------------------
-- Area: Dynamis - Xarcabard
--  Mob: Marquis Nebiros
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
    { x = -127.792, y = -23.643, z = -32.870 }
}

entity.phList =
{
    [ID.mob.MARQUIS_NEBIROS - 2] = ID.mob.MARQUIS_NEBIROS, -- Kindred_Summoner
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
