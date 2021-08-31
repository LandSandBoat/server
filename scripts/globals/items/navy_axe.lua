-----------------------------------
-- ID: 17957
-- Item: Navy Axe
-- Item Effect: TP +100
-- Duration: Instant
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    target:addTP(1000)
end

return item_object
