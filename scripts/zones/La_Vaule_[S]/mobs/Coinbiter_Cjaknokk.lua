-----------------------------------
-- Area: La Vaule [S]
--   NM: Coinbiter Cjaknokk
-----------------------------------
mixins = { require("scripts/mixins/job_special") }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.random(7200, 14400)) -- 2 to 4 hours
end

return entity
