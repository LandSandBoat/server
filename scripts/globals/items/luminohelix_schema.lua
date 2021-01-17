-----------------------------------------
-- ID: 6047
-- Luminohelix Schema
-- Teaches the black magic Luminohelix
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(285)
end

item_object.onItemUse = function(target)
    target:addSpell(285)
end

return item_object
