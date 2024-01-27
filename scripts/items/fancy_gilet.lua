-----------------------------------
-- ID: 25774
-- Fancy Gilet
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
