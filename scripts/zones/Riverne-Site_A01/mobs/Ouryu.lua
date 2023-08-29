-----------------------------------
-- Ouryu Cometh
-- Riverne Site A, Cloud Evokers
-- !pos 184 0 344 30
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/magic")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobSkillAttack(0)
    mob:setAnimationSub(0)
    if mob:hasStatusEffect(xi.effect.ALL_MISS) then
        mob:delStatusEffect(xi.effect.ALL_MISS)
    end

    mob:addImmunity(xi.immunity.SLOW)
    mob:addImmunity(xi.immunity.ELEGY)
    mob:addImmunity(xi.immunity.STUN)
    mob:addImmunity(xi.immunity.TERROR)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 50)
    mob:setMobMod(xi.mobMod.WEAPON_BONUS, 53) -- Level 90 + 2 + 60 = 145 Base Weapon Damage
    mob:setMod(xi.mod.UDMGRANGE, -5000)
    mob:setMod(xi.mod.UDMGMAGIC, -5000)
    mob:setMod(xi.mod.UFASTCAST, 90)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 20)
    mob:setMod(xi.mod.DEF, 459)
    mob:setMod(xi.mod.EVA, 422)
    mob:setMod(xi.mod.ATT, 436)
    mob:setMod(xi.mod.MATT, 0) -- Damage output does not show any MATT bonus
    mob:setMod(xi.mod.REFRESH, 200)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.DRAW_IN, 1)
    mob:setMobMod(xi.mobMod.DRAW_IN_CUSTOM_RANGE, 15)
    mob:setMobMod(xi.mobMod.DRAW_IN_FRONT, 1)

    mob:setLocalVar("twoHour", 0)
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.OURYU_OVERWHELMER)
end

entity.onMobEngaged = function(mob)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
end

entity.onMobFight = function(mob, target)
    -- use 2hr on 10 min cooldown
    if mob:getBattleTime() / 15 > mob:getLocalVar("twohour") then
        mob:useMobAbility(694)
        mob:setLocalVar("twohour", math.random((mob:getBattleTime() / 15) + 36, (mob:getBattleTime() / 15) + 40))
    end

    if mob:actionQueueEmpty() and mob:canUseAbilities() then
        local changeTime = mob:getLocalVar("changeTime")

        -- first flight
        if mob:getAnimationSub() == 0 and mob:getBattleTime() - changeTime > 60 then
            mob:setAnimationSub(1)
            mob:addStatusEffectEx(xi.effect.ALL_MISS, 0, 1, 0, 0)
            mob:setMobSkillAttack(731)
            mob:setLocalVar("changeTime", mob:getBattleTime())
        -- land
        elseif mob:getAnimationSub() == 1 and mob:getBattleTime() - changeTime > 120 then
            mob:useMobAbility(1302)
        -- fly
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
        (target:hasStatusEffect(xi.effect.SLEEP_I) or
        target:hasStatusEffect(xi.effect.SLEEP_II) or
        target:hasStatusEffect(xi.effect.LULLABY))
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

-- Prevents any stuck logic due to wipes
entity.onMobDisengage = function(mob)
    mob:setLocalVar("changeTime", 0)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENSTONE, { power = math.random(45, 90), chance = 10 })
end

return entity
