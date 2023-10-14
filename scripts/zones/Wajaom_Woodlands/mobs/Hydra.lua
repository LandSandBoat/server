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
    { x = -280.20, y = -23.88, z =  -5.94 },
    { x = -272.08, y = -23.75, z =  -1.73 },
    { x = -276.90, y = -24.00, z =   2.09 },
    { x = -268.59, y = -23.96, z = -16.00 },
    { x = -285.57, y = -24.20, z =  -0.56 },
    { x = -282.16, y = -24.00, z =   1.95 },
    { x = -271.35, y = -23.66, z =  -5.46 },
    { x = -272.75, y = -23.55, z = -11.25 },
}

entity.onMobFight = function(mob, target)
    local battletime = mob:getBattleTime()
    local broken = mob:getAnimationSub()

    if
        mob:getLocalVar("headgrow") < battletime and
        broken > 4
    then
        mob:setAnimationSub(broken - 1)
        mob:setLocalVar("headgrow", battletime + 300)
    end

    if
        (target:getXPos() < -295 or target:getXPos() > -260 or
        target:getZPos() < -25 or target:getZPos() > 13) and
        os.time() > mob:getLocalVar("DrawInWait")
    then
        local pos = math.random(1, 8)

        target:setPos(drawInPos[pos])
        mob:messageBasic(232, 0, 0, target)
        mob:setLocalVar("DrawInWait", os.time() + 2)
    end
end

entity.onCriticalHit = function(mob)
    local battletime = mob:getBattleTime()
    local broken = mob:getAnimationSub()

    if
        math.random() <= 0.15 and
        battletime >= mob:getLocalVar("headbreak") and
        broken < 6
    then
        mob:setAnimationSub(broken + 1)
        mob:setLocalVar("headgrow", battletime + math.random(120, 240))
        mob:setLocalVar("headbreak", battletime + 300)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.HYDRA_HEADHUNTER)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.random(48, 72) * 3600) -- 48 to 72 hours, in 1 hour windows
end

return entity
