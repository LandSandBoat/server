-----------------------------------
-- ID: 16249
-- Elixir Tank
-- When used, you will obtain one Elixir
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.ELIXIR, 1)
end

return itemObject
