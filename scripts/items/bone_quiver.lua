-----------------------------------
-- ID: 4220
-- Item: Bone Quiver
-- When used, you will obtain one stack of Bone Arrows
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.BONE_ARROW, 99)
end

return itemObject
