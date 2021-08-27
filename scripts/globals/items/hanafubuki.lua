-----------------------------------
-- ID: 18427
-- Item: Hanafubuki
-- Item Effect: TP +10
-- Durration: Instant
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    return result
end

item_object.onItemUse = function(target)
    target:addTP(100)
end

return item_object
