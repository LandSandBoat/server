-----------------------------------
-- Area: Palborough Mines
--   NM: Qu'Vho Deathhurler
-----------------------------------
mixins = { require("scripts/mixins/job_special") }
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 221)
end

entity.onMobDespawn = function(mob)
    xi.mob.nmTODPersist(mob, math.random(3600, 4200)) -- 60 to 70 minutes
end

return entity
