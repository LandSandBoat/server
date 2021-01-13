-----------------------------------
-- Area: Jugner_Forest
--   NM: Fradubio
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
end

function onMobDespawn(mob)
    UpdateNMSpawnPoint(mob:getID())
end

return entity
