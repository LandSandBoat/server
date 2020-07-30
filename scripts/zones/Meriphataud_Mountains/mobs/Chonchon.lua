-----------------------------------
-- Area: Meriphataud Mountains
--   NM: Chonchon
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/mobs")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
    mob:setMod(tpz.mod.DOUBLE_ATTACK, 20) -- "Double Attack: Frequent and accurate"
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.ENSTONE)
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 270)
end

function onMobDespawn(mob)
    mob:setRespawnTime(math.random(3600, 5400)) -- 60 to 90 minutes
end
