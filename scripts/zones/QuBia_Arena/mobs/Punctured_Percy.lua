-----------------------------------
-- Area: Qu'Bia Arena
--  Mob: Punctured Percy
-- BCNM: Celery
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onMobEngaged (mob, target)
    local mobId = mob:getID()
    DespawnMob(mobId - 3)
    DespawnMob(mobId - 2)
    DespawnMob(mobId - 1)
end

function onMobDeath(mob, player, isKiller)
end
