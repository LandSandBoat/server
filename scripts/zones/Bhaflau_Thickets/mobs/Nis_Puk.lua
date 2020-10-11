-----------------------------------
-- Area: Bhaflau Thickets
--   NM: Nis Puk
-- !pos -155.319 -15.959 -599.366 52
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/mobs")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.ENAERO)
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 453)
end
