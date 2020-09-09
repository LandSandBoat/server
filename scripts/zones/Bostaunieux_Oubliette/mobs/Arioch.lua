-----------------------------------
-- Area: Bostaunieux Oubliette (167)
--   NM: Arioch
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/mobs")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.HP_DRAIN)
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 178)
end
