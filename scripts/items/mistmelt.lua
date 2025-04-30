-----------------------------------
-- ID: 5265
-- Item: Mistmelt
-- Item Effect: Forces Ouryu to land
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, player)
    local result = 0

    if
        target:getBattlefieldID() ~= xi.battlefield.id.SAVAGE or
        target:getName() ~= 'Ouryu'
    then
        result = xi.msg.basic.ITEM_UNABLE_TO_USE
    elseif target:checkDistance(player) > 10 then
        result = xi.msg.basic.TOO_FAR_AWAY
    end

    return result
end

itemObject.onItemUse = function(target, player)
    if target:getAnimationSub() == 1 then
        target:setLocalVar('mistmeltUsed', 1)
    end
end

return itemObject
