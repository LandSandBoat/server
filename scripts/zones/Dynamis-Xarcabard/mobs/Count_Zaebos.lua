-----------------------------------
-- Area: Dynamis - Xarcabard
--  Mob: Count Zaebos
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
    { x =  85.142, y = -24.125, z = -209.879 }
}

entity.phList =
{
    [ID.mob.COUNT_ZAEBOS - 1] = ID.mob.COUNT_ZAEBOS, -- Kindred_Warrior
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
