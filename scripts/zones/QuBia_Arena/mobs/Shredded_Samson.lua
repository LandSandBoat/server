-----------------------------------
-- Area: Qu'Bia Arena
--  Mob: Shredded Samson
-- BCNM: Celery
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

function onMobEngaged (mob, target)
    local mobId = mob:getID()
    DespawnMob(mobId - 1)
    DespawnMob(mobId + 1)
    DespawnMob(mobId + 2)
end

function onMobDeath(mob, player, isKiller)
end

return entity
