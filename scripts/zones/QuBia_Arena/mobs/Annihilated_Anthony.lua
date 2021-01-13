-----------------------------------
-- Area: Qu'Bia Arena
--  Mob: Annihilated Anthony
-- BCNM: Celery
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

function onMobEngaged (mob, target)
    local mobId = mob:getID()
    DespawnMob(mobId + 1)
    DespawnMob(mobId + 2)
    DespawnMob(mobId + 3)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
