-----------------------------------
-- Area: Dynamis - Xarcabard
--  Mob: Marquis Andras
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
    [ID.mob.MARQUIS_ANDRAS - 2] = ID.mob.MARQUIS_ANDRAS, -- Kindred_Beastmaster
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
