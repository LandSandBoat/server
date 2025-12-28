-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Routsix Rubbertendon
-----------------------------------
mixins =
{
    require('scripts/mixins/dynamis_beastmen'),
    require('scripts/mixins/job_special')
}
-----------------------------------
local ID = zones[xi.zone.DYNAMIS_BEAUCEDINE]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  129.595, y = -40.538, z = -75.731 }
}

entity.phList =
{
    [ID.mob.ROUTSIX_RUBBERTENDON - 2] = ID.mob.ROUTSIX_RUBBERTENDON, -- Vanguard_Pathfinder
}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Vanguards_Slime')
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
