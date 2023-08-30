-----------------------------------
-- ID: 5443
-- magnus_stone_pouch
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.MAGNUS_STONE, 99)
end

return itemObject
