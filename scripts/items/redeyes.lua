-----------------------------------
-- ID: 16120
-- redeyes
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.ANGELWING, 99) -- Angelwing x99
    target:messageBasic(xi.msg.basic.ITEM_OBTAINED, 5441)
end

return itemObject
