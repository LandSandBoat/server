-----------------------------------
-- Area: Dynamis - Jeuno
--  Mob: Eremix Snottynostril
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
    { x = -2.084, y =  2.500, z =  107.186 }
}

entity.phList =
{
    [ID.mob.EREMIX_SNOTTYNOSTRIL - 3] = ID.mob.EREMIX_SNOTTYNOSTRIL, -- Vanguard_Shaman       1.584    2.499   111.664
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
