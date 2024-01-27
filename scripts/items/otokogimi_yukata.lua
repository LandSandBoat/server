-----------------------------------
-- ID: 14534
-- otokogimi_yukata
-- Dispense: Datechochin x99
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.DATECHOCHIN, 99)
end

return itemObject
