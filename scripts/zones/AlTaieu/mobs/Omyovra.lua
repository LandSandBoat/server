-----------------------------------
-- Area: Al'Taieu
--  Mob: Om'yovra
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.REGEN, 50)
    mob:setMobMod(xi.mobMod.WEAPON_BONUS, mob:getMainLvl() - 2) -- Base damage is level * 2
    mob:setMod(xi.mod.AGI, 76 - mob:getStat(xi.mod.AGI))        -- Jimmy indicates AGI for Omyovra should be 76 or so
    -- Yovra have a +40% bonus to evasion and a 50% bonus to defense
    mob:addMod(xi.mod.EVA, mob:getStat(xi.mod.EVA) * 0.4) -- TODO: need better evasion mod
    mob:addMod(xi.mod.DEF, mob:getStat(xi.mod.DEF) * 0.5)
    mob:hideName(true)
    mob:setUntargetable(true)
    mob:setAnimationSub(5)
    mob:wait(2000)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.PARALYZE, { duration = math.random(5, 10) })
end

entity.onMobEngage = function(mob, target)
    mob:setLocalVar('disengageTimerActive', 0)
    mob:hideName(false)
    mob:setUntargetable(false)
    mob:setAnimationSub(6)
    mob:wait(2000)
end

entity.onMobDisengage = function(mob)
    mob:setLocalVar('disengageTimerActive', 1)
    mob:timer(15000, function(mobArg)
        if
            mobArg and
            mobArg:getLocalVar('disengageTimerActive') == 1 and
            not mobArg:isEngaged()
        then
            mobArg:hideName(true)
            mobArg:setUntargetable(true)
            mobArg:setAnimationSub(5)
        end
    end)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
