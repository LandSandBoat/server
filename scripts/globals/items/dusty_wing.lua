-----------------------------------
-- ID: 5440
-- Dusty Wing
-- Increases TP of the user by 300
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    target:addTP(3000)
end

return item_object
