-----------------------------------
-- Area: Castle Oztroja [S]
--   NM: Marquis Forneus
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setRespawnTime(math.randomInt(900, 10800))
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.randomInt(18000, 21600)) -- 5 to 6 hours
end

return entity
