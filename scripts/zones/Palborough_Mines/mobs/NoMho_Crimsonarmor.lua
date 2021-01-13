-----------------------------------
-- Area: Palborough Mines
--   NM: No'Mho Crimsonarmor
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
end

function onMobDespawn(mob)
    mob:setRespawnTime(math.random(75600, 86400)) -- 21 to 24 hours
end

return entity
