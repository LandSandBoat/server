-----------------------------------
-- Area: Eastern Altepa Desert (114)
--   NM: Centurio XII-I
-----------------------------------

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)

    -- Set Centurio XII-I's spawnpoint and respawn time (21-24 hours)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random((75600), (86400)))

end
