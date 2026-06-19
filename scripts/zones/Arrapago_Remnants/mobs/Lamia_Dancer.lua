-----------------------------------
-- Area: Arrapago Remnants
--  Mob: Lamia Dancer
-----------------------------------
mixins = { require('scripts/mixins/weapon_break') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobFight = function(mob, target)
    local elemental = GetMobByID(mob:getID() + 1, mob:getInstance())

    if not elemental then
        return
    end

    if elemental:isAlive() and not elemental:isEngaged() then
        elemental:updateEnmity(target)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    local instance  = mob:getInstance()
    local elemental = GetMobByID(mob:getID() + 1, instance)

    if optParams.isKiller then
        if instance and instance:getStage() == 1 then
            instance:setProgress(instance:getProgress() + 1)
        end

        if instance then
            xi.salvage.spawnTempChest(mob, {})
        end
    end

    if elemental and elemental:isAlive() then
        elemental:setHP(0)
    end
end

entity.onMobDespawn = function(mob)
end

return entity
