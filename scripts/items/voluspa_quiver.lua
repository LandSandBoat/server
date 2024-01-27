-----------------------------------
-- ID: 6420
-- Voluspa Quiver
-- When used, you will obtain one stack of Voluspa Arrows
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.VOLUSPA_ARROW, 99)
end

return itemObject
