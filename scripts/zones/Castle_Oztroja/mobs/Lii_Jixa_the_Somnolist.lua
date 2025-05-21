-----------------------------------
-- Area: Castle Oztroja (151)
--   NM: Lii Jixa the Somnolist
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.SILENCE)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 306)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.random(3600, 5400)) -- 60 to 90 minutes
end

return entity
