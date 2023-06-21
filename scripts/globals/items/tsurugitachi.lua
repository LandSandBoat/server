-----------------------------------
-- ID: 18444
-- Item: Tsurugitachi
-- Item Effect: TP +10
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
