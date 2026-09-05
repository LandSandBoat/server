-----------------------------------
-- Area: Leujaoam Sanctum (Leujaoam Cleansing)
--  Mob: Leujaoam Worm
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.HPP, 20)
end

entity.onMobSpawn = function(mob)
    xi.assault.adjustMobLevel(mob)
end

entity.onMobDeath = function(mob, player, optParams)
    local instance = mob:getInstance()
    if not instance then
        return
    end

    if mob:getLocalVar('Killed') == 0 then
        instance:setProgress(instance:getProgress() + 1)
        mob:setLocalVar('Killed', 1)
    end
end

return entity
