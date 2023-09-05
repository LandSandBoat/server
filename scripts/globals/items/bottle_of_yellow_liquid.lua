-----------------------------------
--  ID: 5264
--  Item: Yellow Liquid
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0

    if target:hasStatusEffect(xi.effect.FOOD) then
        result = xi.msg.basic.IS_FULL
    elseif target:getFamily() ~= 503 then
        result = xi.msg.basic.ITEM_UNABLE_TO_USE
    end

    return result
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 30, 5264)
end

return itemObject
