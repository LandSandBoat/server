-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Soo Jopo the Fiendking
-----------------------------------
mixins =
{
    require('scripts/mixins/dynamis_beastmen'),
    require('scripts/mixins/job_special'),
    require('scripts/mixins/remove_doom')
}
-----------------------------------
local ID = zones[xi.zone.DYNAMIS_BEAUCEDINE]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  173.743, y = -20.049, z = -4.091 }
}

entity.phList =
{
    [ID.mob.SOO_JOPO_THE_FIENDKING - 2] = ID.mob.SOO_JOPO_THE_FIENDKING, -- Vanguard_Ogresoother
}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Vanguards_Crow')
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
