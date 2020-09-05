-----------------------------------
-- Area: Toraimarai Canal
--   NM: Konjac
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/mobs")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.HP_DRAIN, {chance = 20})
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 285)
end
