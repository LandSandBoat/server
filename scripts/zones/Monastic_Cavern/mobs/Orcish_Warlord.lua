-----------------------------------
-- Area: Monastic Cavern
--   NM: Orcish Warlord
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.randomInt(1260, 1440)) -- 21 to 24 minutes
end

return entity
