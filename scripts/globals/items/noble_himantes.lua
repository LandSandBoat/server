-----------------------------------
-- ID: 18755
-- Item: Noble Himantes
-- Item Effect: TP +100
-- Durration: Instant
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    target:addTP(100)
end

return itemObject
