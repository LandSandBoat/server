-----------------------------------------
-- ID: 6048
-- Noctohelix Schema
-- Teaches the black magic Noctohelix
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(284)
end

item_object.onItemUse = function(target)
    target:addSpell(284)
end

return item_object
