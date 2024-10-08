-----------------------------------
-- Area: Lebros Cavern (Wamoura Farm Raid)
--  Mob: Ranch Wamouracampa
-----------------------------------
mixins = { require('scripts/mixins/families/wamouracampa') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    -- Eclosion should be between 10-20 minutes
    if mob:getLocalVar('eclosionTime') ~= 0 then
        mob:setLocalVar('eclosionTime', os.time() + math.random(600, 1200))
    end
end

entity.onMobEngage = function(mob, target)
end

entity.onMobDisengage = function(mob)
    if mob:getLocalVar('eclosionTime') ~= 0 then
        mob:setLocalVar('eclosionTime', os.time() + math.random(600, 1200))
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobWeaponSkill = function(target, mob, skill)
    if skill:getID() == 1970 then
        mob:setLocalVar('usedEclosion', 1)
    end
end

entity.onMobDespawn = function(mob)
    if mob:getLocalVar('usedEclosion') ~= 0 then
        return
    end

    local instance = mob:getInstance()
    if not instance then
        return
    end

    instance:setProgress(instance:getProgress() + 1)
end

return entity
