-----------------------------------
-- Area: Sea Serpent Grotto
--   NM: Mouu the Waverider
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.SEA_SERPENT_GROTTO]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -82.000, y =  21.000, z =  62.000 }
}

entity.phList =
{
    [ID.mob.MOUU_THE_WAVERIDER - 1] = ID.mob.MOUU_THE_WAVERIDER, -- -60.728 19.884 53.966
}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Sahagins_Wyvern')
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 380)
end

return entity
