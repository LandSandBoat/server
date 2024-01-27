-----------------------------------
-- ID: 13689
-- Hi-Ether Tank
-- When used, you will obtain one hi-ether
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.HI_ETHER, 1)
end

return itemObject
