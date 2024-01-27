-----------------------------------
-- ID: 25775
-- Fancy Top
-- Dispenses Persikos Snow Cone
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.PERSIKOS_SNOW_CONE)
end

return itemObject
