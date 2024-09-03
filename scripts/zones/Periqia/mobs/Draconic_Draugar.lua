-----------------------------------
-- Area: Periqia (Requiem)
--  Mob: Draconic Draugar
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobEngage = function(mob, target)
    local instance = mob:getInstance()
    local mobID = mob:getID()

    SpawnMob(mobID + 1, instance):updateEnmity(target)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    local instance = mob:getInstance()
    if not instance then
        return
    end

    instance:setProgress(instance:getProgress() + 1)
end

return entity
