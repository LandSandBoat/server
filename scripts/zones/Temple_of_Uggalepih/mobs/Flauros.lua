-----------------------------------
-- Area: Temple of Uggalepih
--   NM: Flauros
-----------------------------------
require("scripts/globals/hunts")
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/mobs")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.ENTHUNDER)
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 384)
end
