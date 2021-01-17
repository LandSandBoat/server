-----------------------------------------
-- ID: 6042
-- Hydrohelix Schema
-- Teaches the black magic Hydrohelix
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(279)
end

item_object.onItemUse = function(target)
    target:addSpell(279)
end

return item_object
