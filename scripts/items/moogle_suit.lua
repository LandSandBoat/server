-----------------------------------
-- ID: 10250
-- Moogle Suit
-- Dispense: Mog Missile
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.MOG_MISSILE, 1)
end

return itemObject
