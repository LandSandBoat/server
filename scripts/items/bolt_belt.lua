-----------------------------------
-- ID: 15289
-- Bolt Belt
-- When used, you will obtain one stack of Bronze Bolts
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.BRONZE_BOLT, 99)
end

return itemObject
