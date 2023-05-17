-----------------------------------
-- Area: Upper Delkfutt's Tower
--   NM: Alkyoneus
-----------------------------------
mixins = { require("scripts/mixins/job_special") }
-----------------------------------
local entity = {}

entity.onMobDespawn = function(mob)
    xi.mob.nmTODPersist(mob, math.random(75600, 86400)) -- 21 to 24 hours
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
