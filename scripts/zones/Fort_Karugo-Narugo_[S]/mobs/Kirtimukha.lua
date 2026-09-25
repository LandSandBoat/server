-----------------------------------
-- Area: Fort Karugo-Narugo [S]
--   NM: Kirtimukha
-----------------------------------
local ID = zones[xi.zone.FORT_KARUGO_NARUGO_S]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.KIRTIMUKHA - 1] = ID.mob.KIRTIMUKHA, -- Confirmed on retail
}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Death_Jacket')
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 523)
end

return entity
