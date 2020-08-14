-----------------------------------
-- Area: Buburimu Peninsula
--   NM: Wake Warder Wanda
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/status")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.MAGIC_COOL, 50) -- just one spell to spam
end

function onMobEngaged(mob, target)
    mob:setMod(tpz.mod.REGAIN, 25)
end

function onMobDisengage(mob)
    mob:setMod(tpz.mod.REGAIN, 0)
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 260)
end

function onMobDespawn(mob)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random(3600, 4200)) -- repop 60-70min
end
