-----------------------------------------
-- ID: 6041
-- Pyrohelix Schema
-- Teaches the black magic Pyrohelix
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(281)
end

item_object.onItemUse = function(target)
    target:addSpell(281)
end

return item_object
