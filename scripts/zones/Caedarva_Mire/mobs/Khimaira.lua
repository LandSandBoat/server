-----------------------------------
-- Area: Caedarva Mire
--   NM: Khimaira
-----------------------------------
require("scripts/globals/titles")
-----------------------------------
local entity = {}

local drawInPos =
{
    {838.88,  0.00, 358.86},
    {834.93, -0.14, 363.68},
    {840.13, -0.31, 366.46},
    {842.69,  0.00, 360.12},
    {846.15, -0.27, 360.25},
    {845.30, -0.51, 366.68},
    {850.33, -1.34, 365.43},
    {850.40, -1.45, 355.85},
}

entity.onMobFight = function(mob, target)
    local drawInWait = mob:getLocalVar("DrawInWait")

    if (target:getXPos() < 814 or target:getXPos() > 865) and os.time() > drawInWait then
        local rot = target:getRotPos()
        local position = math.random(1,8)
        target:setPos(drawInPos[position][1],drawInPos[position][2],drawInPos[position][3],rot)
        mob:messageBasic(232, 0, 0, target)
        mob:setLocalVar("DrawInWait", os.time() + 2)
    elseif (target:getZPos() < 345 or target:getZPos() > 377) and os.time() > drawInWait then
        local rot = target:getRotPos()
        local position = math.random(1,8)
        target:setPos(drawInPos[position][1],drawInPos[position][2],drawInPos[position][3],rot)
        mob:messageBasic(232, 0, 0, target)
        mob:setLocalVar("DrawInWait", os.time() + 2)
    end
end

entity.onMobDeath = function(mob, player, isKiller)
    player:addTitle(xi.title.KHIMAIRA_CARVER)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.random(48, 72) * 3600) -- 48 to 72 hours, in 1-hour increments
end

return entity
