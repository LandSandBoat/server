-----------------------------------
-- Area: Periqia (Requiem)
--  Mob: Darkling Draugar
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.NO_LINK, 1)
    mob:setMaxMP(4075)
    mob:setHP(4075)
end

entity.onMobDespawn = function(mob)
    local instance = mob:getInstance()
    if not instance then
        return
    end

    instance:setProgress(instance:getProgress() + 1)
end

return entity
