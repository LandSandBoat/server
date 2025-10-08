-----------------------------------
-- Area: Fort Karugo-Narugo [S]
--   NM: Kirtimukha
-----------------------------------
local ID = zones[xi.zone.FORT_KARUGO_NARUGO_S]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  24.010, y = -67.138, z = -240.132 }
}

entity.phList =
{
    [ID.mob.KIRTIMUKHA - 8] = ID.mob.KIRTIMUKHA,
    [ID.mob.KIRTIMUKHA - 7] = ID.mob.KIRTIMUKHA,
    [ID.mob.KIRTIMUKHA - 6] = ID.mob.KIRTIMUKHA,
    [ID.mob.KIRTIMUKHA - 5] = ID.mob.KIRTIMUKHA,
    [ID.mob.KIRTIMUKHA - 4] = ID.mob.KIRTIMUKHA,
    [ID.mob.KIRTIMUKHA - 3] = ID.mob.KIRTIMUKHA,
    [ID.mob.KIRTIMUKHA - 1] = ID.mob.KIRTIMUKHA,
}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Death_Jacket')
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 523)
end

return entity
