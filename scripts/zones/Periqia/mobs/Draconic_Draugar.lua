-----------------------------------
-- Area: Periqia (Requiem)
--  Mob: Draconic Draugar
-----------------------------------
local entity = {}

function onMobEngaged(mob, target)
    local instance = mob:getInstance()
    local mobID = mob:getID()

    SpawnMob(mobID +1, instance):updateEnmity(target)
end

entity.onMobDeath = function(mob, player, isKiller)
end

function onMobDespawn(mob)
    local instance = mob:getInstance()
    instance:setProgress(instance:getProgress() + 1)
end

return entity
