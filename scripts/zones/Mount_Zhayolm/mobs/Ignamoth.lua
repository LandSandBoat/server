-----------------------------------
-- Area: Mount Zhayolm
--   NM: Ignamoth
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/mobs")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
    mob:setMod(tpz.mod.DOUBLE_ATTACK, 50)
    mob:setMod(tpz.mod.REGAIN, 200)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.PARALYZE, {duration = 60})
end

function onMobDeath(mob)
    tpz.hunts.checkHunt(mob, player, 457)
end
