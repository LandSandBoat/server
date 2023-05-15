-----------------------------------
-- Area: Sea Serpent Grotto (176)
--   NM: Charybdis
-- !pos -152 48 -328 176
-----------------------------------
local ID = require("scripts/zones/Sea_Serpent_Grotto/IDs")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.MULTI_HIT, 5)
end

entity.onMobSpawn = function(mob)
    -- Ensure PHs can't respawn while alive
    local mantaOne = ID.mob.CHARYBDIS - 2
    local mantaTwo = ID.mob.CHARYBDIS - 4
    DisallowRespawn(mantaOne, true)
    DisallowRespawn(mantaTwo, true)
    DespawnMob(mantaOne)
    DespawnMob(mantaTwo)
end

entity.onMobDeath = function(mob, player, optParams)
    -- Only one Charbydis PH is up at one time
    local chooseManta = math.random(1, 2)
    local mantaOne = ID.mob.CHARYBDIS - 2
    local mantaTwo = ID.mob.CHARYBDIS - 4
    if chooseManta == 2 then
        DisallowRespawn(mantaTwo, false)
        GetMobByID(mantaTwo):setRespawnTime(300)
    elseif chooseManta == 1 then
        DisallowRespawn(mantaOne, false)
        GetMobByID(mantaOne):setRespawnTime(300)
    end
end

return entity
