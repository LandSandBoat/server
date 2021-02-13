-----------------------------------
-- Area: Cape Teriggan
--   NM: Tegmine
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.ENWATER)
end

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 404)
end

entity.onMobDespawn = function(mob)
    -- UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random((7200), (7800))) -- 120 to 130 min
end

return entity
