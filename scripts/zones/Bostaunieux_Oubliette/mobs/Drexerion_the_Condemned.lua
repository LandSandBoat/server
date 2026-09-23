-----------------------------------
-- Area: Bostaunieux Oubliette (167)
--   NM: Drexerion the Condemned
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setRespawnTime(math.randomInt(900, 10800))
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.randomInt(216000, 259200)) -- 60 to 72 hours
end

return entity
