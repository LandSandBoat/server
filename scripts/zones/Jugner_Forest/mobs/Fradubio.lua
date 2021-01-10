-----------------------------------
-- Area: Jugner_Forest
--   NM: Fradubio
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    UpdateNMSpawnPoint(mob:getID())
end

return entity
