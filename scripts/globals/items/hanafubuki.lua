-----------------------------------
-- ID: 18427
-- Item: Hanafubuki
-- Item Effect: TP +100
-- Durration: Instant
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    return result
end

itemObject.onItemUse = function(target)
    target:addTP(100)
end

return itemObject
