-----------------------------------
-- Area: Jugner_Forest
--   NM: Sappy Sycamore
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/status")
require("scripts/globals/mobs")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
    mob:addMod(tpz.mod.SLEEPRES, 20)
    mob:addMod(tpz.mod.BINDRES, 20)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.SLOW, {power = 1500, duration = math.random(15, 25)})
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 159)
end

function onMobDespawn(mob)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random(3600, 4200)) -- repop 60-70min
end
