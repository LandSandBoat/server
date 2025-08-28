-----------------------------------
-- Area: Dynamis - Xarcabard
--  Mob: Count Vine
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
    [ID.mob.COUNT_VINE - 1] = ID.mob.COUNT_VINE, -- Kindred_Samurai
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
