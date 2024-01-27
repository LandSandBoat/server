-----------------------------------
-- ID: 5338
-- Venom Bolt Quiver
-- When used, you will obtain one stack of Venom Bolts
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.VENOM_BOLT, 99)
end

return itemObject
