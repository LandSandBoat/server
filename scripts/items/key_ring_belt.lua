-----------------------------------
-- ID: 15880
-- key_ring_belt
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.SKELETON_KEY)
end

return itemObject
