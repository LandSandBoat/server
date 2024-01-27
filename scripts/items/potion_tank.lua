-----------------------------------
-- ID: 13684
-- Potion Tank
-- When used, you will obtain one Potion
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.POTION, 1)
end

return itemObject
