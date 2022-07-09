-----------------------------------
-- Area: Wajaom Woodlands
--  Mob: Hydra
-- !pos -282 -24 -1 51
-----------------------------------
require("scripts/globals/titles")
-----------------------------------
local entity = {}

local drawInPos =
{
    {-280.20, -23.88,  -5.94},
    {-272.08, -23.75,  -1.73},
    {-276.90, -24.00,   2.09},
    {-268.59, -23.96, -16.00},
    {-285.57, -24.20,  -0.56},
    {-282.16, -24.00,   1.95},
    {-271.35, -23.66,  -5.46},
    {-272.75, -23.55, -11.25},
}

entity.onMobFight = function(mob, target)
    local battletime = mob:getBattleTime()
    local headgrow = mob:getLocalVar("headgrow")
    local broken = mob:getAnimationSub()

    if (headgrow < battletime and broken > 4) then
        mob:setAnimationSub(broken - 1)
        mob:setLocalVar("headgrow", battletime + 300)
    end

    local drawInWait = mob:getLocalVar("DrawInWait")

    if (target:getXPos() < -295 or target:getXPos() > -260) and os.time() > drawInWait then
        local rot = target:getRotPos()
        local position = math.random(1,8)
        target:setPos(drawInPos[position][1],drawInPos[position][2],drawInPos[position][3],rot)
        mob:messageBasic(232, 0, 0, target)
        mob:setLocalVar("DrawInWait", os.time() + 2)
    elseif (target:getZPos() < -25 or target:getZPos() > 13) and os.time() > drawInWait then
        local rot = target:getRotPos()
        local position = math.random(1,8)
        target:setPos(drawInPos[position][1],drawInPos[position][2],drawInPos[position][3],rot)
        mob:messageBasic(232, 0, 0, target)
        mob:setLocalVar("DrawInWait", os.time() + 2)
    end
end

entity.onCriticalHit = function(mob)
    local rand = math.random()
    local battletime = mob:getBattleTime()
    local headbreak = mob:getLocalVar("headbreak")
    local broken = mob:getAnimationSub()

    if (rand <= 0.15 and battletime >= headbreak and broken < 6) then
        mob:setAnimationSub(broken + 1)
        mob:setLocalVar("headgrow", battletime + math.random(120, 240))
        mob:setLocalVar("headbreak", battletime + 300)
    end
end

entity.onMobDeath = function(mob, player, isKiller)
    player:addTitle(xi.title.HYDRA_HEADHUNTER)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.random(48, 72) * 3600) -- 48 to 72 hours, in 1 hour windows
end

return entity
