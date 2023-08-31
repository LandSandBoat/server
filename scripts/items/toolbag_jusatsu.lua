-----------------------------------
-- ID: 5315
-- Toolbag Jusa
-- When used, you will obtain one stack of jusatsu
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.JUSATSU, 99)
end

return itemObject
