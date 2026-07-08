-----------------------------------
-- Area: Phanauet Channel (1)
--   NM: Vodyanoi
-- !pos -2.0 -3.0 9.6 1
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.randomInt(75600, 86400)) -- 21 to 24 hours.
end

return entity
