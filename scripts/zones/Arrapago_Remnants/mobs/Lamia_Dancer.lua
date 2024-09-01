-----------------------------------
-- Area: Arrapago Remnants
--  Mob: Lamia Dancer
-----------------------------------
mixins = { require('scripts/mixins/weapon_break') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    local instance = mob:getInstance()
    if instance and instance:getStage() == 1 then
        instance:setProgress(instance:getProgress() + 1)
    end
end

return entity
