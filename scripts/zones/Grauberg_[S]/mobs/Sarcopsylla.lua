-----------------------------------
-- Area: Grauberg [S]
--   NM: Sarcopsylla
-----------------------------------
mixins = {require("scripts/mixins/families/chigoe")}
require("scripts/globals/mobs")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.ENFIRE)
end

function onMobDeath(mob, player, isKiller)
end
