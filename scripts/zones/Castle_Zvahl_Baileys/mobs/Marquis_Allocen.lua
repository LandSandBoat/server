-----------------------------------
-- Area: Castle Zvahl Baileys (161)
--   NM: Marquis Allocen
-----------------------------------

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)

    -- Set Marquis_Allocen's spawnpoint and respawn time (21-24 hours)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random(75600, 86400))

end
