-----------------------------------
-- Area: Ilrusi Atoll
--  Mob: Cursed Chest
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

local function CheckForDrawnIn(centerX, centerY, centerZ, playerX, playerY, playerZ, rayon, maxRayon)
    local difX = playerX-centerX
    local difY = playerY-centerY
    local difZ = playerZ-centerZ
    local distance = math.sqrt(math.pow(difX, 2) + math.pow(difY, 2) + math.pow(difZ, 2))

    if distance > rayon and distance < maxRayon then
        return true
    else
        return false
    end
end

entity.onMobFight = function(mob, target)
    local playerX = target:getXPos()
    local playerY = target:getYPos()
    local playerZ = target:getZPos()
    local mobX = mob:getXPos()
    local mobY = mob:getYPos()
    local mobZ = mob:getZPos()
    local distanceMin = 3
    local distanceMax = 20

    if CheckForDrawnIn(mobX, mobY, mobZ, playerX, playerY, playerZ, distanceMin, distanceMax) then
        target:setPos(mob:getXPos(), mob:getYPos(), mob:getZPos())
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
