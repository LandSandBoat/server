-----------------------------------
-- Area: Sea Serpent Grotto (176)
--   NM: Charybdis
-- !pos -152 48 -328 176
-----------------------------------
local ID = require("scripts/zones/Sea_Serpent_Grotto/IDs")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.MULTI_HIT, 5)
end

entity.onMobDeath = function(mob, player, optParams)
    -- Remove the listener added from xi.mob.phOnDespawn
    -- This is necessary to use multiple different PH IDs for one NM
    mob:removeListener("DESPAWN_" .. mob:getID())
    DisallowRespawn(mob:getID(), true)
end

entity.onMobDespawn = function(mob, player, optParams)
    -- 8 hour minimum respawn. also a function of xi.mob.phOnDespawn's listener.
    mob:setLocalVar("pop", os.time() + 28800)

    -- Only one Charbydis PH is up at one time
    local chooseManta = math.random(1, 2)
    local mantaOne = ID.mob.CHARYBDIS - 2
    local mantaTwo = ID.mob.CHARYBDIS - 4

    if chooseManta == 2 then
        DisallowRespawn(mantaOne, true)
        DisallowRespawn(mantaTwo, false)
        GetMobByID(mantaTwo):setRespawnTime(GetMobRespawnTime(mantaTwo))
    elseif chooseManta == 1 then
        DisallowRespawn(mantaOne, false)
        DisallowRespawn(mantaTwo, true)
        GetMobByID(mantaOne):setRespawnTime(GetMobRespawnTime(mantaOne))
    end
end

return entity
