-----------------------------------
-- Area: Cape Teriggan
--   NM: Tegmine
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/mobs")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.ENWATER)
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 404)
end

function onMobDespawn(mob)
    -- UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random((7200), (7800))) -- 120 to 130 min
end
