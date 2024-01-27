-----------------------------------
-- ID: 26271
-- Hi-Elixir Tank
-- When used, you will obtain one hi-elixir
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.HI_ELIXIR, 1)
end

return itemObject
