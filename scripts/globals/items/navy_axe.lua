-----------------------------------
-- ID: 17957
-- Item: Navy Axe
-- Item Effect: TP +100
-- Duration: Instant
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    target:addTP(1000)
end

return itemObject
