-----------------------------------
-- Area: Riverne Site B01
-- Note: Weaker version of Tiamat summoned by Bahamut during The Wyrmking Descends
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:SetMobSkillAttack(0) -- Resetting so it doesn't respawn in flight mode
    mob:setAnimationSub(0) -- AnimationSub 0 is only used when it spawns until first flight

    mob:setMobMod(xi.mobMod.SIGHT_RANGE, 30)
    mob:setMobMod(xi.mobMod.GA_CHANCE, 70)
    mob:setMobMod(xi.mobMod.BUFF_CHANCE, 30)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:addMod(xi.mod.SLEEPRES, 100)
    mob:addMod(xi.mod.LULLABYRES, 100)
    mob:setMod(xi.mod.MDEF, 100) -- 385 * 1.32/2 = 254 nether blast
    mob:setMod(xi.mod.DEF, 500)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 25)
    mob:setMod(xi.mod.MATT, 0)
end

entity.onMobFight = function(mob, target)
    -- Gains a large attack boost when health is under 25% which cannot be Dispelled
    if mob:getHPP() < 25 then
        if mob:hasStatusEffect(xi.effect.ATTACK_BOOST) == false then
            mob:addStatusEffect(xi.effect.ATTACK_BOOST, 75, 0, 0)
            mob:getStatusEffect(xi.effect.ATTACK_BOOST):setFlag(xi.effectFlag.DEATH)
        end
    -- Deletes Effect if regens back up due to a wipe
    else
        if mob:hasStatusEffect(xi.effect.ATTACK_BOOST) == true then
            mob:delStatusEffect(xi.effect.ATTACK_BOOST)
        end
    end

    if mob:hasStatusEffect(xi.effect.MIGHTY_STRIKES) == false and mob:actionQueueEmpty() == true then
        local changeTime = mob:getLocalVar("changeTime")
        local twohourTime = mob:getLocalVar("twohourTime")
        local changeHP = mob:getLocalVar("changeHP")

        if twohourTime == 0 then
            twohourTime = math.random(8, 14)
            mob:setLocalVar("twohourTime", twohourTime)
        end

        if mob:getAnimationSub() == 2 and mob:getBattleTime()/15 > twohourTime then
            mob:useMobAbility(688)
            mob:setLocalVar("twohourTime", math.random((mob:getBattleTime()/15)+4, (mob:getBattleTime()/15)+8))
        elseif mob:getAnimationSub() == 0 and mob:getBattleTime() - changeTime > 60 then
            mob:setAnimationSub(1)
            mob:addStatusEffectEx(xi.effect.ALL_MISS, 0, 1, 0, 0)
            mob:SetMobSkillAttack(730)
            mob:setLocalVar("changeTime", mob:getBattleTime()) -- Record the time and HP this phase was started
            mob:setLocalVar("changeHP", mob:getHP()/1000)
        -- AnimationSub 1 is flight, so check if she should land
        elseif mob:getAnimationSub() == 1 and (mob:getHP()/1000 <= changeHP - 10 or mob:getBattleTime() - changeTime > 120) then
            mob:useMobAbility(1282)
            mob:setLocalVar("changeTime", mob:getBattleTime())
            mob:setLocalVar("changeHP", mob:getHP()/1000)
        -- AnimationSub 2 is grounded mode, so check if she should take off
        elseif mob:getAnimationSub() == 2 and (mob:getHP()/1000 <= changeHP - 10 or mob:getBattleTime() - changeTime > 120) then
            mob:setAnimationSub(1)
            mob:addStatusEffectEx(xi.effect.ALL_MISS, 0, 1, 0, 0)
            mob:SetMobSkillAttack(730)
            mob:setLocalVar("changeTime", mob:getBattleTime())
            mob:setLocalVar("changeHP", mob:getHP()/1000)
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
    mob:setLocalVar("changeHP", 0)
end

entity.onCastStarting = function(mob, spell)
    if spell:getID() == 176 then -- firaga iii
        spell:castTime(spell:castTime()/2) -- really fast cast (2x)
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENFIRE, {power = math.random(45, 90), chance = 10})
end

return entity
