-----------------------------------
-- Area: Monastic Cavern
--   NM: Orcish Hexspinner
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.random(1260, 1440)) -- 21 to 24 minutes
end

return entity
