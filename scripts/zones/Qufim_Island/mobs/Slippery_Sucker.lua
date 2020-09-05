-----------------------------------
-- Area: Qufim Island
--   NM: Slippery Sucker
-----------------------------------
require("scripts/globals/mobs")
require("scripts/globals/hunts")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.STUN)
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 308)
end
