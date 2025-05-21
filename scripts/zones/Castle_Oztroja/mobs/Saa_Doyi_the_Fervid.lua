-----------------------------------
-- Area: Castle Oztroja (151)
--   NM: Saa Doyi the Fervid
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.SILENCE)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 304)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.random(3600, 7200)) -- 1 to 2 hours
end

return entity
