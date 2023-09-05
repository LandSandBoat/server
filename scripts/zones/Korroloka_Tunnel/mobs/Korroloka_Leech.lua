-----------------------------------
-- Area: Korroloka Tunnel
--   NM: Korroloka Leech
-- Involved in Quest: Ayame and Kaede
-----------------------------------
local ID = require("scripts/zones/Korroloka_Tunnel/IDs")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
end

entity.onMobSpawn = function(mob)
    DespawnMob(mob:getID(), 180)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
