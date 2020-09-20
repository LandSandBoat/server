-----------------------------------
-- Area: Monarch Linn
--  Mob: Ouryu
-----------------------------------
require("scripts/globals/titles")
-----------------------------------

function onMobSpawn(mob)
    mob:SetMobSkillAttack(0) -- resetting so it doesn't respawn in flight mode.
    mob:AnimationSub(0) -- subanim 0 is only used when it spawns until first flight.
end

function onMobFight(mob, target)

    local bf = mob:getBattlefield()
    if bf:getID() == 961 and mob:getHPP() < 30 then
        bf:win()
        return
    end

    if (mob:hasStatusEffect(tpz.effect.INVINCIBLE) == false and mob:actionQueueEmpty() == true) then
        local changeTime = mob:getLocalVar("changeTime")
        local twohourTime = mob:getLocalVar("twohourTime")

        if (twohourTime == 0) then
            twohourTime = math.random(8, 14)
            mob:setLocalVar("twohourTime", twohourTime)
        end

        if (mob:AnimationSub() == 2 and mob:getBattleTime()/15 > twohourTime) then
            mob:useMobAbility(694)
            mob:setLocalVar("twohourTime", math.random((mob:getBattleTime()/15)+12, (mob:getBattleTime()/15)+16))
        elseif (mob:AnimationSub() == 0 and mob:getBattleTime() - changeTime > 60) then
            mob:AnimationSub(1)
            mob:addStatusEffectEx(tpz.effect.TOO_HIGH, 0, 1, 0, 0)
            mob:SetMobSkillAttack(731)
            --and record the time this phase was started
            mob:setLocalVar("changeTime", mob:getBattleTime())
        -- subanimation 1 is flight, so check if he should land
        elseif (mob:AnimationSub() == 1 and
                mob:getBattleTime() - changeTime > 120) then
            mob:useMobAbility(1302)
            mob:setLocalVar("changeTime", mob:getBattleTime())
        -- subanimation 2 is grounded mode, so check if he should take off
        elseif (mob:AnimationSub() == 2 and
                mob:getBattleTime() - changeTime > 120) then
            mob:AnimationSub(1)
            mob:addStatusEffectEx(tpz.effect.TOO_HIGH, 0, 1, 0, 0)
            mob:SetMobSkillAttack(731)
            mob:setLocalVar("changeTime", mob:getBattleTime())
        end
    end
end

function onMobDeath(mob, player, isKiller)

    player:addTitle(tpz.title.MIST_MELTER)

end
