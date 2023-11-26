-----------------------------------
-- Area: Caedarva Mire
--   NM: Khimaira
-----------------------------------
require("scripts/globals/titles")
-----------------------------------
local entity = {}

local drawInPos =
{
    { x = 838.88, y =  0.00, z = 358.86 },
    { x = 834.93, y = -0.14, z = 363.68 },
    { x = 840.13, y = -0.31, z = 366.46 },
    { x = 842.69, y =  0.00, z = 360.12 },
    { x = 846.15, y = -0.27, z = 360.25 },
    { x = 845.30, y = -0.51, z = 366.68 },
    { x = 850.33, y = -1.34, z = 365.43 },
    { x = 850.40, y = -1.45, z = 355.85 },
}

entity.onMobFight = function(mob, target)
    if
        (target:getXPos() < 814 or target:getXPos() > 865 or
        target:getZPos() < 345 or target:getZPos() > 377) and
        os.time() > mob:getLocalVar("DrawInWait")
    then
        local pos = math.random(1, 8)

        target:setPos(drawInPos[pos])
        mob:messageBasic(232, 0, 0, target)
        mob:setLocalVar("DrawInWait", os.time() + 2)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.KHIMAIRA_CARVER)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.random(48, 72) * 3600) -- 48 to 72 hours, in 1-hour increments
end

return entity
