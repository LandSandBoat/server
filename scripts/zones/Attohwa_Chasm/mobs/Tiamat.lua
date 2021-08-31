-----------------------------------
-- Area: Attohwa Chasm
--  Mob: Tiamat
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:SetMobSkillAttack(0) -- resetting so it doesn't respawn in flight mode.
    mob:setAnimationSub(0) -- subanim 0 is only used when it spawns until first flight.
end

entity.onMobFight = function(mob, target)

    -- Gains a large attack boost when health is under 25% which cannot be Dispelled.
    if (mob:getHP() < ((mob:getMaxHP() / 10) * 2.5)) then
        if (mob:hasStatusEffect(xi.effect.ATTACK_BOOST) == false) then
            mob:addStatusEffect(xi.effect.ATTACK_BOOST, 75, 0, 0)
            mob:getStatusEffect(xi.effect.ATTACK_BOOST):setFlag(xi.effectFlag.DEATH)
        end
    end

    if (mob:hasStatusEffect(xi.effect.MIGHTY_STRIKES) == false and mob:actionQueueEmpty() == true) then
        local changeTime = mob:getLocalVar("changeTime")
        local twohourTime = mob:getLocalVar("twohourTime")
        local changeHP = mob:getLocalVar("changeHP")

        if (twohourTime == 0) then
            twohourTime = math.random(8, 14)
            mob:setLocalVar("twohourTime", twohourTime)
        end

        if (mob:getAnimationSub() == 2 and mob:getBattleTime()/15 > twohourTime) then
            mob:useMobAbility(688)
            mob:setLocalVar("twohourTime", math.random((mob:getBattleTime()/15)+4, (mob:getBattleTime()/15)+8))
        elseif (mob:getAnimationSub() == 0 and mob:getBattleTime() - changeTime > 60) then
            mob:setAnimationSub(1)
            mob:addStatusEffectEx(xi.effect.ALL_MISS, 0, 1, 0, 0)
            mob:SetMobSkillAttack(730)
            --and record the time and HP this phase was started
            mob:setLocalVar("changeTime", mob:getBattleTime())
            mob:setLocalVar("changeHP", mob:getHP()/1000)
        -- subanimation 1 is flight, so check if she should land
        elseif (mob:getAnimationSub() == 1 and (mob:getHP()/1000 <= changeHP - 10 or
                mob:getBattleTime() - changeTime > 120)) then
            mob:useMobAbility(1282)
            mob:setLocalVar("changeTime", mob:getBattleTime())
            mob:setLocalVar("changeHP", mob:getHP()/1000)
        -- subanimation 2 is grounded mode, so check if she should take off
        elseif (mob:getAnimationSub() == 2 and (mob:getHP()/1000 <= changeHP - 10 or
                mob:getBattleTime() - changeTime > 120)) then
            mob:setAnimationSub(1)
            mob:addStatusEffectEx(xi.effect.ALL_MISS, 0, 1, 0, 0)
            mob:SetMobSkillAttack(730)
            mob:setLocalVar("changeTime", mob:getBattleTime())
            mob:setLocalVar("changeHP", mob:getHP()/1000)
        end
    end
end

entity.onMobDeath = function(mob, player, isKiller)
    player:addTitle(xi.title.TIAMAT_TROUNCER)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.random(259200, 432000)) -- 3 to 5 days
end

return entity
