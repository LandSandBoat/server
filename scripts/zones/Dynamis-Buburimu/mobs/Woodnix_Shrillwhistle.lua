-----------------------------------
-- Area: Dynamis - Buburimu
--  Mob: Woodnix Shrillwhistle
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
    { x =  43.488, y = -16.666, z = -6.216 }
}

entity.phList =
{
    [ID.mob.WOODNIX_SHRILLWHISTLE - 6] = ID.mob.WOODNIX_SHRILLWHISTLE, -- Vanguard_Pathfinder
}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Woodnixs_Slime')
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
