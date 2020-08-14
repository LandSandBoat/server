-----------------------------------
-- Area: Sauromugue Champaign [S]
--   NM: Coquecigrue
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/mobs")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.PETRIFY)
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 532)
end

function onMobDespawn(mob)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random(7200, 7800)) -- 2 hours plus 10 minute window
end
