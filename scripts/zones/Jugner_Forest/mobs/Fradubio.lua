-----------------------------------
-- Area: Jugner_Forest
--   NM: Fradubio
-----------------------------------

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    UpdateNMSpawnPoint(mob:getID())
end
