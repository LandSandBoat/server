-----------------------------------
-- ID: 18945
-- Item: Jet Sickle
-- Item Effect: TP +100
-- Duration: Instant
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    target:addTP(100)
end

return itemObject
