-----------------------------------
-- Area: Riverne Site A01
-- Note: Ouryu Cometh
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:SetMobSkillAttack(0)
    mob:setAnimationSub(0)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
    mob:setLocalVar("savageDmgMultipliers", 1)
    mob:setLocalVar("twoHour", 0)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 50)
    mob:addMod(xi.mod.EARTH_MEVA, 1000)
    mob:setMod(xi.mod.BLINDRES, 25)
    mob:addMod(xi.mod.PARALYZERES, 25)
    mob:setMod(xi.mod.UDMGRANGE, -5000)
    -- mob:setMod(xi.mod.MATT, -25)
    -- mob:setMod(xi.mod.ATT, -50)
    mob:setMod(xi.mod.UFASTCAST, 90)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.DRAW_IN, 1)
    mob:setMobMod(xi.mobMod.DRAW_IN_CUSTOM_RANGE, 15)
    mob:setMobMod(xi.mobMod.DRAW_IN_FRONT, 1)
end

entity.onMobEngaged = function(mob)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
end

entity.onMobFight = function(mob, target)
    local twohourTime = mob:getLocalVar("twohour")
    -- use 2hr on 10 min cooldown
    if mob:getBattleTime()/15 > twohourTime then
        mob:useMobAbility(694)
        mob:setLocalVar("twohour", math.random((mob:getBattleTime()/15)+36, (mob:getBattleTime()/15)+40))
    end

    if mob:canUseAbilities() then
        local changeTime = mob:getLocalVar("changeTime")
        print(mob:getBattleTime() - changeTime)

        -- first flight
        if mob:getAnimationSub() == 0 and mob:getBattleTime() - changeTime > 60 then
            mob:setAnimationSub(1)
            mob:addStatusEffectEx(xi.effect.ALL_MISS, 0, 1, 0, 0)
            mob:SetMobSkillAttack(731)
            mob:setLocalVar("changeTime", mob:getBattleTime())
        -- land
        elseif mob:getAnimationSub() == 1 and mob:getBattleTime() - changeTime > 120 then
            mob:useMobAbility(1302)
            mob:setLocalVar("changeTime", mob:getBattleTime())
        -- fly
        elseif mob:getAnimationSub() == 2 and mob:getBattleTime() - changeTime > 120 then
            mob:setAnimationSub(1)
            mob:addStatusEffectEx(xi.effect.ALL_MISS, 0, 1, 0, 0)
            mob:SetMobSkillAttack(731)
            mob:setLocalVar("changeTime", mob:getBattleTime())
        end
    end

    -- Wakeup from sleep immediately if flying
    if mob:getAnimationSub() == 1 and
    (mob:hasStatusEffect(xi.effect.SLEEP_I) or
    mob:hasStatusEffect(xi.effect.SLEEP_II) or
    mob:hasStatusEffect(xi.effect.LULLABY)) then
        mob:wakeUp()
    end
end

-- Prevents any stuck logic due to wipes
entity.onMobDisengage = function(mob)
    mob:setLocalVar("changeTime", 0)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENSTONE, {power = math.random(45, 90), chance = 10})
end

return entity
