-----------------------------------
-- Area: Qu'Bia Arena
--  Mob: Mauled Murdock
-- BCNM: Celery
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onMobEngaged (mob, target)
    local mobId = mob:getID()
    DespawnMob(mobId - 2)
    DespawnMob(mobId - 1)
    DespawnMob(mobId + 1)
end

function onMobDeath(mob, player, isKiller)
end
