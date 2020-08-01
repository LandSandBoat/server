-----------------------------------
-- Area: Ilrusi Atoll
--  Mob: Cursed Chest
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onMobFight(mob, target)
    local PX = target:getXPos()
    local PY = target:getYPos()
    local PZ = target:getZPos()
    local MX = mob:getXPos()
    local MY = mob:getYPos()
    local MZ = mob:getZPos()
    local distanceMin = 3
    local distanceMax = 20
    if (CheckForDrawnIn(MX, MY, MZ, PX, PY, PZ, distanceMin, distanceMax) == true) then
        target:setPos(mob:getXPos(), mob:getYPos(), mob:getZPos())
    end
end

function CheckForDrawnIn(centerX, centerY, centerZ, playerX, playerY, playerZ, Rayon, maxRayon)
    local difX = playerX-centerX
    local difY = playerY-centerY
    local difZ = playerZ-centerZ
    local Distance = math.sqrt( math.pow(difX, 2) + math.pow(difY, 2) + math.pow(difZ, 2) )

    if (Distance > Rayon and Distance < maxRayon) then
        return true
    else
        return false
    end
end

function onMobDeath(mob, player, isKiller)
end
