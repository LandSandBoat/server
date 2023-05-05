-----------------------------------
-- Area: Castle Zvahl Baileys (161)
--   NM: Duke Haborym
-----------------------------------
require("scripts/globals/roe")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.roe.onRecordTrigger(player, 299)
end

entity.onMobDespawn = function(mob)
    -- Set Duke_Haborym's spawnpoint and respawn time (21-24 hours)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random(75600, 86400))
end

return entity
