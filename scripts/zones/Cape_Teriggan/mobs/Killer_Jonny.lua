-----------------------------------
-- Area: Cape Teriggan
--   NM: Killer Jonny
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/status")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
    mob:setMod(tpz.mod.DOUBLE_ATTACK, 100)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.POISON, {power = 120})
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 407)
end

function onMobDespawn(mob)
    mob:setRespawnTime(math.random(28800, 86400)) -- 8 to 24 hours
end
