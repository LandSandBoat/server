-----------------------------------
-- ID: 4223
-- Scorpion Quiver
-- When used, you will obtain one stack of Scorpion Arrows
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.SCORPION_ARROW, 99)
end

return itemObject
