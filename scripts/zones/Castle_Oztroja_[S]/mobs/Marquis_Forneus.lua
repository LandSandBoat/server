-----------------------------------
-- Area: Castle Oztroja [S]
--   NM: Marquis Forneus
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random(18000, 21600)) -- 5 to 6 hours
end

return entity
