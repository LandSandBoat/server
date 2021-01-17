-----------------------------------------
-- ID: 4167
-- Cracker
-- Creates a simple puff of smoke with a "crack" noise
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
end

return item_object
