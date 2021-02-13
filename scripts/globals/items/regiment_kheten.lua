-----------------------------------
-- ID: 18493
-- Item: Regiment Kheten
-- Item Effect: TP +10
-- Durration: Instant
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    result = 0
    return result
end

item_object.onItemUse = function(target)
    target:addTP(100)
end

return item_object
