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

    -- He holds at 1 HP once beaten. The animation waits for his next tp move.
    mob:addListener('TAKE_DAMAGE', 'SHADOW_LORD_DEATH_DAMAGE', function(mobArg, damage)
        if
            mobArg:getLocalVar('[ShadowLord]Defeated') == 0 and
            damage >= mobArg:getHP()
        then
            mobArg:setUnkillable(true)
            mobArg:setLocalVar('[ShadowLord]Defeated', GetSystemTime())
        end
    end)
end

entity.onMobSpawn = function(mob)
    mob:setUnkillable(false)
    mob:setLocalVar('[ShadowLord]Defeated', 0)
    mob:setLocalVar('[ShadowLord]DefeatTime', 0)
    mob:setLocalVar('lastImplodeTime', 0)
    mob:setAutoAttackEnabled(false)
    mob:setMagicCastingEnabled(false)
    mob:setMobAbilityEnabled(false)
end

entity.onMobFight = function(mob, target)
    if mob:getLocalVar('[ShadowLord]DefeatTime') > 0 then
        return
    end

    local currentTime     = GetSystemTime()
    local lastImplodeTime = mob:getLocalVar('lastImplodeTime')

    if lastImplodeTime == 0 then
        mob:setLocalVar('lastImplodeTime', currentTime)
        return
    end

    if currentTime - lastImplodeTime < 9 then
        return
    end

    -- The death animation takes the slot the next implosion would have used.
    if mob:getLocalVar('[ShadowLord]Defeated') > 0 then
        mob:useMobAbility(xi.mobSkill.SHADOW_LORD_DEATH, mob)
    else
        mob:useMobAbility(xi.mobSkill.IMPLOSION)
    end

    mob:setLocalVar('lastImplodeTime', currentTime)
end

return entity
