-----------------------------------
-- Area: Bostaunieux Oubliette (167)
--   NM: Shii
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/mobs")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1) -- "has an Additional Effect: Terror in melee attacks"
    mob:setMod(tpz.mod.REGEN, 20) -- "also has an Auto Regen of medium strength" (guessing 20)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.TERROR)
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 179)
end
