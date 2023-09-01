-----------------------------------
-- ID: 5864
-- Toolbag Jinko
-- When used, you will obtain one stack of jinko
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.JINKO, 99)
end

return itemObject
