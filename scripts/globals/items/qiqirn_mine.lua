-----------------------------------------
-- ID: 5331
-- Item: Qiqirn Mine
-- When used, Summons a bomb to blowup a wall
-----------------------------------------
require("scripts/globals/zone")
require("scripts/globals/status")
-----------------------------------------

function onItemCheck(target)
    local result = 0
    if target:getZoneID() ~= tpz.zone.LEBROS_CAVERN then
        result = 55
    end
    return result
end

function onItemUse(target)
    local instance = target:getInstance()
    local bomb = instance:insertAlly(10633)
    local X = target:getXPos()
    local Z = target:getZPos()

    if (X > 161 and X < 184) and (Z > 359 and Z < 378)then
        bomb:setSpawn(178, -40, 376, 196)
        bomb:spawn()
    elseif (X > 254 and X < 264) and (Z > 192 and Z < 218)then
        bomb:setSpawn(258, -30, 213, 190)
        bomb:spawn()
    elseif (X > 327 and X < 343) and (Z > 278 and Z < 298)then
        bomb:setSpawn(338, -30, 296, 197)
        bomb:spawn()
    elseif (X > 300 and X < 320) and (Z > 335 and Z < 343)then
        bomb:setSpawn(303, -30, 341, 167)
        bomb:spawn()
    else
        bomb:setSpawn(X + math.random(-2, 2), target:getYPos() , Z + math.random(-2, 2))
        bomb:spawn()
    end

    bomb:updateEnmity(target)
end
