-----------------------------------
-- Area: Riverne Site B01
-- Note: Weaker version of Jormungand summoned by Bahamut during The Wyrmking Descends
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:SetMobSkillAttack(0) -- resetting so it doesn't respawn in flight mode.
    mob:setAnimationSub(0) -- subanim 0 is only used when it spawns until first flight.

    mob:setMobMod(xi.mobMod.SIGHT_RANGE, 30)
    mob:setMobMod(xi.mobMod.SIGHT_ANGLE, 90)
    mob:setMobMod(xi.mobMod.GA_CHANCE, 80)
    mob:setMobMod(xi.mobMod.BUFF_CHANCE, 20)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:addMod(xi.mod.SLEEPRES, 100)
    mob:addMod(xi.mod.LULLABYRES, 100)
    mob:setMod(xi.mod.MDEF, 124) -- 385 * 1.32/2.24 = 226 nether blast
    mob:setMod(xi.mod.DEF, 500)
    mob:setMod(xi.mod.MATT, 0)
end

entity.onMobFight = function(mob, target)
    if mob:hasStatusEffect(xi.effect.BLOOD_WEAPON) == false and mob:actionQueueEmpty() == true then
        local changeTime = mob:getLocalVar("changeTime")
        local twohourTime = mob:getLocalVar("twohourTime")

        if twohourTime == 0 then
            twohourTime = math.random(8, 14)
            mob:setLocalVar("twohourTime", twohourTime)
        end

        if mob:getAnimationSub() == 2 and mob:getBattleTime()/15 > twohourTime then
            mob:useMobAbility(695)
            mob:setLocalVar("twohourTime", (mob:getBattleTime()/15) +20)
        elseif mob:getAnimationSub() == 0 and mob:getBattleTime() - changeTime > 60 then
            mob:setAnimationSub(1)
            mob:addStatusEffectEx(xi.effect.ALL_MISS, 0, 1, 0, 0)
            mob:SetMobSkillAttack(732)
            -- and record the time this phase was started
            mob:setLocalVar("changeTime", mob:getBattleTime())
        -- subanimation 1 is flight, so check if he should land
        elseif mob:getAnimationSub() == 1 and mob:getBattleTime() - changeTime > 30 then
            mob:useMobAbility(1292)
            mob:setLocalVar("changeTime", mob:getBattleTime())
        -- subanimation 2 is grounded mode, so check if he should take off
        elseif mob:getAnimationSub() == 2 and mob:getBattleTime() - changeTime > 60 then
            mob:setAnimationSub(1)
            mob:addStatusEffectEx(xi.effect.ALL_MISS, 0, 1, 0, 0)
            mob:SetMobSkillAttack(732)
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
    mob:setLocalVar("twohourTime", 0)
    mob:setLocalVar("roarCounter", 0)
end

entity.onMobWeaponSkill = function(target, mob, skill)
    if skill:getID() == 1296 and mob:getHPP() <= 30 then
        local roarCounter = mob:getLocalVar("roarCounter")

        roarCounter = roarCounter +1
        mob:setLocalVar("roarCounter", roarCounter)

        if roarCounter > 2 then
            mob:setLocalVar("roarCounter", 0)
        else
            mob:useMobAbility(1296)
        end
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENBLIZZARD, {power = math.random(45, 90), chance = 10})
end

return entity
