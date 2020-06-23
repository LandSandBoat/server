-----------------------------------
-- Area: Sauromugue Champaign [S]
--   NM: Hyakinthos
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/mobs")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.PARALYZE, {chance = 50}) -- "Attacks have Additional Effect: Paralyze, which has a high proc rate."
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 530)
end

function onMobDespawn(mob)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random(5400, 7200)) -- 90 to 120 minutes
end
