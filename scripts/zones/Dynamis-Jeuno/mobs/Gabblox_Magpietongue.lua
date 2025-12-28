-----------------------------------
-- Area: Dynamis - Jeuno
--  Mob: Gabblox Magpietongue
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
    { x = -0.250, y =  8.500, z = -53.982 }
}

entity.phList =
{
    [ID.mob.GABBLOX_MAGPIETONGUE - 2] = ID.mob.GABBLOX_MAGPIETONGUE, -- Vanguard_Armorer      2.179    8.5     -61.613
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
