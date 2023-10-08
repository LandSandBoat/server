-----------------------------------
-- Area: Monarch Linn
--  Mob: Ouryu
-----------------------------------
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobSpawn = function(mob)
    mob:setMobSkillAttack(0) -- resetting so it doesn't respawn in flight mode.
    mob:setAnimationSub(0) -- subanim 0 is only used when it spawns until first flight.
    if mob:hasStatusEffect(xi.effect.ALL_MISS) then
        mob:delStatusEffect(xi.effect.ALL_MISS)
    end

    mob:setMobMod(xi.mobMod.DRAW_IN, 1)
    mob:setMobMod(xi.mobMod.DRAW_IN_CUSTOM_RANGE, 15)
    mob:setMobMod(xi.mobMod.WEAPON_BONUS, 14) -- 54 + 2 + 14 = 70
    mob:setLocalVar("setTwoHourThreshold", math.random(50, 80))
end

entity.onMobFight = function(mob, target)
    local bf = mob:getBattlefield()
    if bf:getID() == 961 and mob:getHPP() < 30 then
        bf:win()
        return
    end

    -- can use invincible on ground or air
    if mob:getHPP() < mob:getLocalVar("setTwoHourThreshold") then
        mob:useMobAbility(694)
        --make sure to use only once in case of regen back above threshold
        mob:setLocalVar("setTwoHourThreshold", 0)
    end

    if
        mob:actionQueueEmpty() and
        mob:canUseAbilities()
    then
        local changeTime = mob:getLocalVar("changeTime")

        if mob:getAnimationSub() == 0 and mob:getBattleTime() - changeTime > 60 then
            mob:setAnimationSub(1)
            mob:addStatusEffectEx(xi.effect.ALL_MISS, 0, 1, 0, 0)
            mob:setMobSkillAttack(731)
            --and record the time this phase was started
            mob:setLocalVar("changeTime", mob:getBattleTime())
        -- subanimation 1 is flight, so check if he should land
        elseif mob:getAnimationSub() == 1 and mob:getBattleTime() - changeTime > 120 then
            -- touchdown ability changes the animation sub, miss status, and mob skill attack
            mob:useMobAbility(1302)
        -- subanimation 2 is grounded mode, so check if he should take off
        elseif mob:getAnimationSub() == 2 and mob:getBattleTime() - changeTime > 120 then
            mob:setAnimationSub(1)
            mob:addStatusEffectEx(xi.effect.ALL_MISS, 0, 1, 0, 0)
            mob:setMobSkillAttack(731)
            mob:setLocalVar("changeTime", mob:getBattleTime())
        end
    end

    -- Wakeup from sleep immediately if flying
    if
        mob:getAnimationSub() == 1 and
        (mob:hasStatusEffect(xi.effect.SLEEP_I) or
        mob:hasStatusEffect(xi.effect.SLEEP_II) or
        mob:hasStatusEffect(xi.effect.LULLABY))
    then
        mob:delStatusEffect(xi.effect.SLEEP_I)
        mob:delStatusEffect(xi.effect.SLEEP_II)
        mob:delStatusEffect(xi.effect.LULLABY)
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    -- only reset change time if actual perform touchdown
    -- thus keep trying until we do so
    if skill:getID() == 1302 then
        mob:setLocalVar("changeTime", mob:getBattleTime())
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENSTONE)
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.MIST_MELTER)
end

return entity
