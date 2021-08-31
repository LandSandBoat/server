-----------------------------------
-- Area: Monarch Linn
--  Mob: Ouryu
-----------------------------------
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:SetMobSkillAttack(0) -- resetting so it doesn't respawn in flight mode.
    mob:setAnimationSub(0) -- subanim 0 is only used when it spawns until first flight.
end

entity.onMobFight = function(mob, target)

    local bf = mob:getBattlefield()
    if bf:getID() == 961 and mob:getHPP() < 30 then
        bf:win()
        return
    end

    if (mob:hasStatusEffect(xi.effect.INVINCIBLE) == false and mob:actionQueueEmpty() == true) then
        local changeTime = mob:getLocalVar("changeTime")
        local twohourTime = mob:getLocalVar("twohourTime")

        if (twohourTime == 0) then
            twohourTime = math.random(8, 14)
            mob:setLocalVar("twohourTime", twohourTime)
        end

        if (mob:getAnimationSub() == 2 and mob:getBattleTime()/15 > twohourTime) then
            mob:useMobAbility(694)
            mob:setLocalVar("twohourTime", math.random((mob:getBattleTime()/15)+12, (mob:getBattleTime()/15)+16))
        elseif (mob:getAnimationSub() == 0 and mob:getBattleTime() - changeTime > 60) then
            mob:setAnimationSub(1)
            mob:addStatusEffectEx(xi.effect.ALL_MISS, 0, 1, 0, 0)
            mob:SetMobSkillAttack(731)
            --and record the time this phase was started
            mob:setLocalVar("changeTime", mob:getBattleTime())
        -- subanimation 1 is flight, so check if he should land
        elseif (mob:getAnimationSub() == 1 and
                mob:getBattleTime() - changeTime > 120) then
            mob:useMobAbility(1302)
            mob:setLocalVar("changeTime", mob:getBattleTime())
        -- subanimation 2 is grounded mode, so check if he should take off
        elseif (mob:getAnimationSub() == 2 and
                mob:getBattleTime() - changeTime > 120) then
            mob:setAnimationSub(1)
            mob:addStatusEffectEx(xi.effect.ALL_MISS, 0, 1, 0, 0)
            mob:SetMobSkillAttack(731)
            mob:setLocalVar("changeTime", mob:getBattleTime())
        end
    end
end

entity.onMobDeath = function(mob, player, isKiller)

    player:addTitle(xi.title.MIST_MELTER)

end

return entity
