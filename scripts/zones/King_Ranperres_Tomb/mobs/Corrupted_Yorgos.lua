-----------------------------------
-- Area: King Ranperres Tomb
--   NM: Corrupted Yorgos
-----------------------------------
local ID = require("scripts/zones/King_Ranperres_Tomb/IDs")
require("scripts/globals/missions")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    mob:setMod(xi.mod.SLEEPRES, 50)
    mob:setMod(xi.mod.LULLABYRES, 50)
end

entity.onMobSpawn = function(mob)
    DespawnMob(mob:getID(), 180)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
