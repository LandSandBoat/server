-----------------------------------
-- Area: Dynamis - Buburimu
--  Mob: VaRhu Bodysnatcher
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

entity.spawnPoints =
{
    { x =  124.312, y = -7.880, z =  31.932 }
}

entity.phList =
{
    [ID.mob.VARHU_BODYSNATCHER - 8] = ID.mob.VARHU_BODYSNATCHER, -- Vanguard_Purloiner
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
