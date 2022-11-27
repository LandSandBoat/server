-----------------------------------
-- Area: Quicksand Caves
--   NM: Proconsul XII
-----------------------------------
require("scripts/globals/hunts")
mixins = { require("scripts/mixins/job_special") }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 437)
end

entity.onMobDespawn = function(mob)
    xi.mob.nmTODPersist(mob, 7200) -- 2 hours
end

return entity
