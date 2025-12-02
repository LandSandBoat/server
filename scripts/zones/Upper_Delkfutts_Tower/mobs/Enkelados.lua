-----------------------------------
-- Area: Upper Delkfutt's Tower
--   NM: Enkelados
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.UPPER_DELKFUTTS_TOWER]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -226.158, y = -144.099, z =  28.522 }
}

entity.phList =
{
    [ID.mob.ENKELADOS[1] + 3] = ID.mob.ENKELADOS[1], -- -371.586 -144.367 28.244
    [ID.mob.ENKELADOS[2] + 3] = ID.mob.ENKELADOS[2], -- -215.194 -144.099 19.528
}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Gigass_Bats')
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 331)
end

return entity
