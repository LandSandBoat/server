-----------------------------------
-- Area: Ordelle's Caves
--   NM: Donggu
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/mobs")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
    mob:setMod(tpz.mod.DOUBLE_ATTACK, 5)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.BLIND)
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 181)
end
