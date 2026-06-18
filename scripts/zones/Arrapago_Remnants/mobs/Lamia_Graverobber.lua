-----------------------------------
-- Area: Arrapago Remnants
--  Mob: Lamia Graverobber
-----------------------------------
mixins = { require('scripts/mixins/weapon_break') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller then
        local instance = mob:getInstance()

        if instance and instance:getStage() == 1 then
            instance:setProgress(instance:getProgress() + 1)
        end

        if instance then
            xi.salvage.spawnTempChest(mob, {})
        end
    end
end

entity.onMobDespawn = function(mob)
end

return entity
