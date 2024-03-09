-----------------------------------
-- Area: Qulun_Dome
--   NM: Hu'Rhe Marrowgorger
-- Note: QNM for An Affable Adamantking
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180) -- 3 min despawn
end

entity.onMobEngage = function(mob, target)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
end

return entity
