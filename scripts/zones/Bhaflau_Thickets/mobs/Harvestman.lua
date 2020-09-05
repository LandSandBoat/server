-----------------------------------
-- Area: Bhaflau Thickets
--   NM: Harvestman
-- !pos 398.130 -10.675 179.169 52
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/mobs")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.POISON, {power = 100, duration = math.random(6, 9)})
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 451)
end

function onMobDespawn(mob)
    -- Set Harvesman's spawnpoint and respawn time (21-24 hours)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random(75600, 86400))
end
