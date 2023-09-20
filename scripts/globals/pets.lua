-----------------------------------
-- Pet Global Functions
-----------------------------------
require('scripts/globals/nyzul/pathos')
-----------------------------------
xi = xi or {}
xi.pet = xi.pet or {}

xi.pet.spawnPet = function(player, petID)
    player:spawnPet(petID)

    -- Nyzul Isle has Pathos set randomly on floors and is recorded as bits in a localvar of the instance
    if player:getZoneID() == xi.zone.NYZUL_ISLE then
        xi.nyzul.addPetSpawnPathos(player)
    end
end
