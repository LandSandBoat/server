-----------------------------------
-- Area: Meriphataud Mountains [S]
--   NM: Centipedal Centruroides
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/mobs")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
    mob:setMod(tpz.mod.DOUBLE_ATTACK, 100)
    mob:setMod(tpz.mod.MOVE, 13)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.POISON, {power = 30})
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 528)
end
