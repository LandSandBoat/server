-----------------------------------
-- Area: Sea Serpent Grotto
--   NM: Zuug the Shoreleaper
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.SEA_SERPENT_GROTTO]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -243.000, y =  41.000, z = -298.000 }
}

entity.phList =
{
    [ID.mob.ZUUG_THE_SHORELEAPER - 4] = ID.mob.ZUUG_THE_SHORELEAPER,
}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Sahagins_Wyvern')
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 382)
end

return entity
