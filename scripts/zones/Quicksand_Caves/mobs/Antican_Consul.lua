-----------------------------------
-- Area: Quicksand Caves
--   NM: Antican Consul
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    mob:setRespawnTime(math.random(75600, 86400)) -- 21 to 24 hours
end

return entity
