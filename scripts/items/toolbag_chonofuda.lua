-----------------------------------
-- ID: 5869
-- Toolbag Cho
-- When used, you will obtain one stack of chonofuda
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.CHONOFUDA, 99)
end

return itemObject
