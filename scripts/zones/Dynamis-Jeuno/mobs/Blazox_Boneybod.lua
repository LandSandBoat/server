-----------------------------------
-- Area: Dynamis - Jeuno
--  Mob: Blazox Boneybod
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
    { x =  0.588, y =  2.350, z =  120.430 }
}

entity.phList =
{
    [ID.mob.BLAZOX_BONEYBOD - 4] = ID.mob.BLAZOX_BONEYBOD, -- Vanguard_Pathfinder   -1.698   2.493   116.454
}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Vanguards_Slime')
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
