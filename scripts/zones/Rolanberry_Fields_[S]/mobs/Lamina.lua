-----------------------------------
-- Area: Rolanberry Fields [S]
--   NM: Lamina
-----------------------------------
require("scripts/globals/mobs")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.SLOW)
end

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    mob:setRespawnTime(math.random(5400, 7200)) -- 90 to 120 minutes
end
