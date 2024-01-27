-----------------------------------
-- ID: 6299
-- Item: Sh. Pouch
-- When used, you will obtain one stack of Shurikens
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.SHURIKEN, 99)
end

return itemObject
