-----------------------------------
-- ID: 5318
-- Toolbag Kodo
-- When used, you will obtain one stack of Kodo
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.KODOKU, 99)
end

return itemObject
