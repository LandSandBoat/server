-----------------------------------
-- Area: Dynamis - Xarcabard
--  Mob: Count Raum
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
    [ID.mob.COUNT_RAUM - 1] = ID.mob.COUNT_RAUM, -- Kindred_Thief
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
