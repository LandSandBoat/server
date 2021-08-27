-----------------------------------
-- Area: Uleguerand Range
--  HNM: Jormungand
-----------------------------------
local entity = {}

require("scripts/globals/status")
require("scripts/globals/titles")

entity.onMobSpawn = function(mob)
    mob:SetMobSkillAttack(0) -- resetting so it doesn't respawn in flight mode.
    mob:setAnimationSub(0) -- subanim 0 is only used when it spawns until first flight.
end

entity.onMobFight = function(mob, target)
    if (mob:hasStatusEffect(xi.effect.BLOOD_WEAPON) == false and mob:actionQueueEmpty() == true) then
        local changeTime = mob:getLocalVar("changeTime")
        local twohourTime = mob:getLocalVar("twohourTime")

        if (twohourTime == 0) then
            twohourTime = math.random(8, 14)
            mob:setLocalVar("twohourTime", twohourTime)
        end

        if (mob:getAnimationSub() == 2 and mob:getBattleTime()/15 > twohourTime) then
            mob:useMobAbility(695)
            mob:setLocalVar("twohourTime", (mob:getBattleTime()/15)+20)
        elseif (mob:getAnimationSub() == 0 and mob:getBattleTime() - changeTime > 60) then
            mob:setAnimationSub(1)
            mob:addStatusEffectEx(xi.effect.ALL_MISS, 0, 1, 0, 0)
            mob:SetMobSkillAttack(732)
            -- and record the time this phase was started
            mob:setLocalVar("changeTime", mob:getBattleTime())
        -- subanimation 1 is flight, so check if he should land
        elseif (mob:getAnimationSub() == 1 and
                mob:getBattleTime() - changeTime > 30) then
            mob:useMobAbility(1292)
            mob:setLocalVar("changeTime", mob:getBattleTime())
        -- subanimation 2 is grounded mode, so check if he should take off
        elseif (mob:getAnimationSub() == 2 and mob:getBattleTime() - changeTime > 60) then
            mob:setAnimationSub(1)
            mob:addStatusEffectEx(xi.effect.ALL_MISS, 0, 1, 0, 0)
            mob:SetMobSkillAttack(732)
            mob:setLocalVar("changeTime", mob:getBattleTime())
        end
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
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

entity.onMobDeath = function(mob, player, isKiller)
    player:addTitle(xi.title.WORLD_SERPENT_SLAYER)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.random(259200, 432000)) -- 3 to 5 days
end

return entity
