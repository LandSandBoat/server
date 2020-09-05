-----------------------------------
-- Area: Qufim Island
--   NM: Qoofim
-----------------------------------
require("scripts/globals/mobs")
require("scripts/globals/hunts")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.ENWATER)
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 309)
end

function onMobDespawn(mob)
    mob:setRespawnTime(math.random(3600, 7200)) -- 1 to 2 hours
end
