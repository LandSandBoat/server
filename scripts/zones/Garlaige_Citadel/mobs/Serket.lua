-----------------------------------
-- Area: Garlaige Citadel (200)
--   NM: Serket
-----------------------------------
mixins = {require("scripts/mixins/rage")}
require("scripts/globals/status")
require("scripts/globals/titles")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.DRAW_IN, 1)
end

function onMobSpawn(mob)
    mob:setLocalVar("[rage]timer", 1800) -- 30 minutes
end

function onMobDeath(mob, player, isKiller)
    player:addTitle(tpz.title.SERKET_BREAKER)
end

function onMobDespawn(mob)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random(75600, 86400)) -- 21 to 24 hours
end
