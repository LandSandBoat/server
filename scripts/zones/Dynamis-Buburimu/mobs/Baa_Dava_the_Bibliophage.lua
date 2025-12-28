-----------------------------------
-- Area: Dynamis - Buburimu
--  Mob: Baa Dava the Bibliophage
-----------------------------------
mixins =
{
    require('scripts/mixins/dynamis_beastmen'),
    require('scripts/mixins/job_special'),
    require('scripts/mixins/remove_doom')
}
-----------------------------------
local ID = zones[xi.zone.DYNAMIS_BUBURIMU]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -2.482, y = -8.474, z = -81.863 }
}

entity.phList =
{
    [ID.mob.BAA_DAVA_THE_BIBLIOPHAGE - 3] = ID.mob.BAA_DAVA_THE_BIBLIOPHAGE, -- Vanguard_Oracle
}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Baas_Avatar')
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
