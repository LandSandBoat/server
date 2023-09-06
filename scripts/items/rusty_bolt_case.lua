-----------------------------------
-- ID: 4197
-- rusty_bolt_case
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.RUSTY_BOLT, 99) -- 99x rusty_bolt
end

return itemObject
