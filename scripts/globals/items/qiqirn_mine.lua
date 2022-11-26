-----------------------------------
-- ID: 5331
-- Item: Qiqirn Mine
-- When used, Summons a bomb to blowup a wall
-----------------------------------
require("scripts/globals/zone")
require("scripts/globals/status")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    if target:getZoneID() ~= xi.zone.LEBROS_CAVERN then
        result = 55
    end

    return result
end

itemObject.onItemUse = function(target)
    local instance = target:getInstance()
    local bomb = instance:insertAlly(100)
    local xPos = target:getXPos()
    local zPos = target:getZPos()
    local targ = target:getTarget()

    if (xPos > 160 and xPos < 186) and (zPos > 359 and zPos < 380) then
        bomb:setSpawn(178, -40, 376, 196)
        bomb:spawn()
    elseif (xPos > 250 and xPos < 264) and (zPos > 192 and zPos < 220) then
        bomb:setSpawn(258, -30, 213, 190)
        bomb:spawn()
    elseif (xPos > 327 and xPos < 343) and (zPos > 278 and zPos < 300) then
        bomb:setSpawn(338, -30, 296, 197)
        bomb:spawn()
    elseif (xPos > 298 and xPos < 320) and (zPos > 330 and zPos < 345) then
        bomb:setSpawn(303, -30, 341, 167)
        bomb:spawn()
    else
        bomb:setSpawn(xPos + math.random(-2, 2), target:getYPos() , zPos + math.random(-2, 2))
        bomb:spawn()
    end

    if targ ~= nil then
        bomb:updateEnmity(targ)
    end
end

return itemObject
