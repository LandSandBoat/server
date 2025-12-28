-----------------------------------
-- Area: Dynamis - Jeuno
--  Mob: Bootrix Jaggedelbow
-----------------------------------
mixins =
{
    require('scripts/mixins/dynamis_beastmen'),
    require('scripts/mixins/job_special')
}
-----------------------------------
local ID = zones[xi.zone.DYNAMIS_JEUNO]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -2.432, y =  2.945, z =  114.931 }
}

entity.phList =
{
    [ID.mob.BOOTRIX_JAGGEDELBOW - 3] = ID.mob.BOOTRIX_JAGGEDELBOW, -- Vanguard_Pitfighter   -2.487   2.418   106.984
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
