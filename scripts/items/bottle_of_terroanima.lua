-----------------------------------
-- ID: 5263
-- Item: Bottle Of Terroanima
-- Item Effect: Terror
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, player)
    local result = 0
    if
        target:getEcosystem() ~= xi.ecosystem.EMPTY and
        player:getZone():getRegionID() == xi.region.PROMYVION
    then
        result = xi.msg.basic.ITEM_UNABLE_TO_USE
    elseif target:checkDistance(player) > 10 then
        result = xi.msg.basic.TOO_FAR_AWAY
    end

    return result
end

itemObject.onItemUse = function(target, player)
    local duration = math.random(25, 32) -- Random duration between 25s and 32s
    target:setLocalVar('EmptyTerror', os.time()) -- Sets terror start time.
    target:setLocalVar('EmptyTerrorDuration', duration) -- Sets terror duration.
end

return itemObject
