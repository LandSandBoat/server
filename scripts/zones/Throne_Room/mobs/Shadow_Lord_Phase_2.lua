-----------------------------------
-- Area: Throne Room
--  Mob: Shadow Lord
-- Mission 5-2 BCNM Fight
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.SILENCE)
end

entity.onMobSpawn = function(mob)
    mob:setAutoAttackEnabled(false)
    mob:setMagicCastingEnabled(false)
    mob:setMobAbilityEnabled(false)
end

entity.onMobFight = function(mob, target)
    local currentTime     = GetSystemTime()
    local lastImplodeTime = mob:getLocalVar('lastImplodeTime')

    if lastImplodeTime == 0 then
        mob:setLocalVar('lastImplodeTime', currentTime)
        return
    end

    if currentTime - lastImplodeTime >= 9 then
        mob:useMobAbility(xi.mobSkill.IMPLOSION)
        mob:setLocalVar('lastImplodeTime', currentTime)
    end
end

return entity
