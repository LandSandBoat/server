-----------------------------------
-- ID: 14532
-- otoko_yukata
-- Dispense: Muteppo x99
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.MUTEPPO, 99)
end

return itemObject
