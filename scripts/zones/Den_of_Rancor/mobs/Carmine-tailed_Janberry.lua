-----------------------------------
-- Area: Den of Rancor
--   NM: Carmine-tailed Janberry
-----------------------------------
mixins =
{
    require('scripts/mixins/families/tonberry'),
    require('scripts/mixins/job_special')
}
-----------------------------------
local ID = zones[xi.zone.DEN_OF_RANCOR]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  0.500, y =  36.000, z = -87.000 }
}

entity.phList =
{
    [ID.mob.CARMINE_TAILED_JANBERRY + 2] = ID.mob.CARMINE_TAILED_JANBERRY,
    [ID.mob.CARMINE_TAILED_JANBERRY + 3] = ID.mob.CARMINE_TAILED_JANBERRY,
}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Tonberrys_Elemental')
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
