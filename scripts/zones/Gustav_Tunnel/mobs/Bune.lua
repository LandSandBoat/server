-----------------------------------
-- Area: Gustav Tunnel
--   NM: Bune
-----------------------------------

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)

    -- Set Bune's spawnpoint and respawn time (21-24 hours)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random(75600, 86400))

end
