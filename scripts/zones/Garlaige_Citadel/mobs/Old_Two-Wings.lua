-----------------------------------
-- Area: Garlaige Citadel (200)
--   NM: Old Two-Wings
-----------------------------------

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)

    -- Set Old_Two_Wings's spawnpoint and respawn time (21-24 hours)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random(75600, 86400))

end
