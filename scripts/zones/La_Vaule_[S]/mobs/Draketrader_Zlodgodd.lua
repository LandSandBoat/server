-----------------------------------
-- Area: La Vaule [S]
--   NM: Draketrader Zlodgodd
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    mob:setRespawnTime(math.random(7200, 18000)) -- 2 to 5 hours
end

return entity
