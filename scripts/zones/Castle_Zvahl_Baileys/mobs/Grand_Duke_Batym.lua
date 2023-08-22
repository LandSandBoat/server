-----------------------------------
-- Area: Castle Zvahl Baileys (161)
--   NM: Grand Duke Batym
-----------------------------------
mixins = { require("scripts/mixins/job_special") }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.nmTODPersist(mob, math.random(75600, 86400)) -- 21 to 24 hours
end

return entity
