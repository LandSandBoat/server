-----------------------------------
-- Area: Bostaunieux Oubliette (167)
--   NM: Phanduron the Condemned
-----------------------------------
mixins = { require("scripts/mixins/job_special") }
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.EVA_DOWN)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random(216000, 259200)) -- 60 to 72 hours
end

return entity
