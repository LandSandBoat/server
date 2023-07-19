-----------------------------------
-- ID: 26788
-- Item: Rabbit Cap
-- When used, you will obtain 1-2 random initial eggs
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    if target:getFreeSlotsCount() == 0 then
        result = xi.msg.basic.ITEM_NO_USE_INVENTORY
    end

    return result
end

itemObject.onItemUse = function(target)
    target:addItem(math.random(xi.items.A_EGG, xi.items.Z_EGG))

    if math.random(1, 5) > 4 then
        target:addItem(math.random(xi.items.A_EGG, xi.items.Z_EGG))
    end
end

return itemObject
