-----------------------------------
-- ID: 5821
-- Fusion Bolt Quiver
-- When used, you will obtain one stack of Fusion Bolts
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.FUSION_BOLT, 99)
end

return itemObject
