-----------------------------------
-- Area: Dynamis - Buburimu
--  Mob: Flamecaller Zoeqdoq
-----------------------------------
mixins =
{
    require('scripts/mixins/dynamis_beastmen'),
    require('scripts/mixins/job_special')
}
-----------------------------------
local ID = zones[xi.zone.DYNAMIS_BUBURIMU]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.FLAMECALLER_ZOEQDOQ - 12] = ID.mob.FLAMECALLER_ZOEQDOQ, -- Vanguard_Mesmerizer
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
