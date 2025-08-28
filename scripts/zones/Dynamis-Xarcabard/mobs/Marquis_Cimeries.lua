-----------------------------------
-- Area: Dynamis - Xarcabard
--  Mob: Marquis Cimeries
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

entity.phList =
{
    [ID.mob.MARQUIS_CIMERIES - 1] = ID.mob.MARQUIS_CIMERIES, -- Kindred_Ranger
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
