-----------------------------------
-- Area: Uleguerand Range
--  HNM: Jormungand
-----------------------------------

require("scripts/globals/status")
require("scripts/globals/titles")

function onMobSpawn(mob)
    mob:SetMobSkillAttack(0) -- resetting so it doesn't respawn in flight mode.
    mob:AnimationSub(0) -- subanim 0 is only used when it spawns until first flight.
end

function onMobFight(mob, target)
    if (mob:hasStatusEffect(tpz.effect.BLOOD_WEAPON) == false and mob:actionQueueEmpty() == true) then
        local changeTime = mob:getLocalVar("changeTime")
        local twohourTime = mob:getLocalVar("twohourTime")

        if (twohourTime == 0) then
            twohourTime = math.random(8, 14)
            mob:setLocalVar("twohourTime", twohourTime)
        end

        if (mob:AnimationSub() == 2 and mob:getBattleTime()/15 > twohourTime) then
            mob:useMobAbility(695)
            mob:setLocalVar("twohourTime", (mob:getBattleTime()/15)+20)
        elseif (mob:AnimationSub() == 0 and mob:getBattleTime() - changeTime > 60) then
            mob:AnimationSub(1)
            mob:addStatusEffectEx(tpz.effect.TOO_HIGH, 0, 1, 0, 0)
            mob:SetMobSkillAttack(732)
            -- and record the time this phase was started
            mob:setLocalVar("changeTime", mob:getBattleTime())
        -- subanimation 1 is flight, so check if he should land
        elseif (mob:AnimationSub() == 1 and
                mob:getBattleTime() - changeTime > 30) then
            mob:useMobAbility(1292)
            mob:setLocalVar("changeTime", mob:getBattleTime())
        -- subanimation 2 is grounded mode, so check if he should take off
        elseif (mob:AnimationSub() == 2 and mob:getBattleTime() - changeTime > 60) then
            mob:AnimationSub(1)
            mob:addStatusEffectEx(tpz.effect.TOO_HIGH, 0, 1, 0, 0)
            mob:SetMobSkillAttack(732)
            mob:setLocalVar("changeTime", mob:getBattleTime())
        end
    end
end

function onMobWeaponSkill(target, mob, skill)
    if (skill:getID() == 1296 and mob:getHPP() <= 30) then
        local roarCounter = mob:getLocalVar("roarCounter")

        roarCounter = roarCounter +1
        mob:setLocalVar("roarCounter", roarCounter)

        if (roarCounter > 2) then
            mob:setLocalVar("roarCounter", 0)
        else
            mob:useMobAbility(1296)
        end
    end
end

function onMobDeath(mob, player, isKiller)
    player:addTitle(tpz.title.WORLD_SERPENT_SLAYER)
end

function onMobDespawn(mob)
    mob:setRespawnTime(math.random(259200, 432000)) -- 3 to 5 days
end
