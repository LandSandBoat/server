-----------------------------------
-- ID: 6429
-- Voluspa Volt Quiver
-- When used, you will obtain one stack of Voluspa Bolts
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.VOLUSPA_BOLT, 99)
end

return itemObject
