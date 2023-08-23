-----------------------------------
-- ID: 18035
-- Item: Deathbone Knife
-- Item Effect: TP +10
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
