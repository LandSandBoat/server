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
    -- 8 hour minimum, this is also set in the Charbydis script due to the multi-placeholders.
    -- See the Charbydis script for more.

    if not xi.mob.phOnDespawn(mob, ID.mob.CHARYBDIS_PH, 10, 28800) then
        -- Charbydis is not queued to spawn.
        -- Choose a Charbydis PH randomly to spawn next.
        local chooseManta = math.random(1, 2)
        local mantaOne = ID.mob.CHARYBDIS - 2
        local mantaTwo = ID.mob.CHARYBDIS - 4

        if chooseManta == 2 then
            GetMobByID(mantaTwo):setRespawnTime(GetMobRespawnTime(mantaTwo))
            DisallowRespawn(mantaOne, true)
            DisallowRespawn(mantaTwo, false)
        elseif chooseManta == 1 then
            GetMobByID(mantaOne):setRespawnTime(GetMobRespawnTime(mantaOne))
            DisallowRespawn(mantaOne, false)
            DisallowRespawn(mantaTwo, true)
        end
    end
end

return entity
