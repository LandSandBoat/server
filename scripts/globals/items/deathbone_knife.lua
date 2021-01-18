-----------------------------------
-- ID: 18035
-- Item: Deathbone Knife
-- Item Effect: TP +10
-- Duration: Instant
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    target:addTP(100)
end

return item_object
