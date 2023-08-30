-----------------------------------
--  ID: 13683
--  Water Tank
--  When used, you will obtain one stack of Distilled Water
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.FLASK_OF_DISTILLED_WATER, 12)
end

return itemObject
