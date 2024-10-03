-----------------------------------
-- Area: Arrapago Remnants
--  Mob: Lamia Dancer
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.applyMixins(mob, xi.mixins.weapon_break)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    local instance = mob:getInstance()
    if instance and instance:getStage() == 1 then
        instance:setProgress(instance:getProgress() + 1)
    end
end

return entity
