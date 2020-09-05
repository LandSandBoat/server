-----------------------------------
-- Area: Castle Zvahl Baileys (161)
--   NM: Grand Duke Batym
-----------------------------------

mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/status")

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    -- Set Grand_Duke_Batym's spawnpoint and respawn time (21-24 hours)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random(75600, 86400))
end
