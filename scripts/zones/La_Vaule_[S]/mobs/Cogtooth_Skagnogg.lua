-----------------------------------
-- Area: La Vaule [S]
--   NM: Cogtooth Skagnogg
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.randomInt(7200, 14400)) -- 2 to 4 hours
end

return entity
