-----------------------------------
-- ID: 5331
-- Item: Qiqirn Mine
-- When used, Summons a bomb to blowup a wall
-----------------------------------
require("scripts/globals/zone")
require("scripts/globals/status")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if target:getZoneID() ~= xi.zone.LEBROS_CAVERN then
        result = 55
    end
    return result
end

item_object.onItemUse = function(target)
    local instance = target:getInstance()
    local bomb = instance:insertAlly(100)
    local X = target:getXPos()
    local Z = target:getZPos()
    local targ = target:getTarget()

    if (X > 160 and X < 186) and (Z > 359 and Z < 380) then
        bomb:setSpawn(178,-40,376,196)
        bomb:spawn()
    elseif (X > 250 and X < 264) and (Z > 192 and Z < 220) then
        bomb:setSpawn(258,-30,213,190)
        bomb:spawn()
    elseif (X > 327 and X < 343) and (Z > 278 and Z < 300) then
        bomb:setSpawn(338,-30,296,197)
        bomb:spawn()
    elseif (X > 298 and X < 320) and (Z > 330 and Z < 345) then
        bomb:setSpawn(303,-30,341,167)
        bomb:spawn()
    else
        bomb:setSpawn(X + math.random(-2,2), target:getYPos() , Z + math.random(-2,2))
        bomb:spawn()
    end

    if targ ~= nil then
        bomb:updateEnmity(targ)
    end
end

return item_object
