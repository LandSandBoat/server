-----------------------------------
-- Area: Arrapago Remnants
--  Mob: Archaic Gears
-----------------------------------
mixins = { require('scripts/mixins/families/gears') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    local instance = mob:getInstance()
    if
        instance and
        instance:getStage() == 6 and
        instance:getProgress() >= 1
    then
        if optParams.isKiller then
            instance:setProgress(instance:getProgress() + 1)
        end
    end
end

entity.onMobDespawn = function(mob)
end

return entity
