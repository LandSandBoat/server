-----------------------------------
-- Area: Sea Serpent Grotto (176)
--  Mob: Devil Manta
-- Note: Place holder Charybdis
-----------------------------------
local ID = require("scripts/zones/Sea_Serpent_Grotto/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 810, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    -- Only one Charbydis PH is up at one time
    local chooseManta = math.random(1, 2)
    local mantaOne = ID.mob.CHARYBDIS - 2
    local mantaTwo = ID.mob.CHARYBDIS - 4
    if mob:getID() == mantaOne and chooseManta == 2 then
        DisallowRespawn(mantaOne, true)
        DisallowRespawn(mantaTwo, false)
        GetMobByID(mantaTwo):setRespawnTime(960)
    elseif mob:getID() == mantaTwo and chooseManta == 1 then
        DisallowRespawn(mantaOne, false)
        DisallowRespawn(mantaTwo, true)
        GetMobByID(mantaOne):setRespawnTime(960)
    end

    xi.mob.phOnDespawn(mob, ID.mob.CHARYBDIS_PH, 10, 28800) -- 8 hour minimum
end

return entity
