-----------------------------------
-- ID: 4202
-- Daedalus Wing
-- Increases TP of the user by 100
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    target:addTP(1000)
end

return item_object
