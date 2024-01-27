-----------------------------------
-- ID: 26788
-- Item: Rabbit Cap
-- When used, you will obtain 1-2 random initial eggs
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(math.random(xi.item.A_EGG, xi.item.Z_EGG))

    if math.random(1, 5) > 4 then
        target:addItem(math.random(xi.item.A_EGG, xi.item.Z_EGG))
    end
end

return itemObject
