-----------------------------------
-- Area: Alzadaal Undersea Ruins (72)
--   NM: Cookieduster Lipiroon
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/status")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.POISON, {power = 70})
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 477)
end
