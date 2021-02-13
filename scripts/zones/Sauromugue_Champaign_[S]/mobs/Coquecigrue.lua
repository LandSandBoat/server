-----------------------------------
-- Area: Sauromugue Champaign [S]
--   NM: Coquecigrue
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.PETRIFY)
end

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 532)
end

entity.onMobDespawn = function(mob)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random(7200, 7800)) -- 2 hours plus 10 minute window
end

return entity
