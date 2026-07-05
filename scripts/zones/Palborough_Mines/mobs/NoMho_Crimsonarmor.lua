-----------------------------------
-- Area: Palborough Mines
--   NM: No'Mho Crimsonarmor
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.randomInt(75600, 86400)) -- 21 to 24 hours
end

return entity
