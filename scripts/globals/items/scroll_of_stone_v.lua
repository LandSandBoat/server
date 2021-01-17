-----------------------------------------
-- ID: 4771
-- Scroll of Stone V
-- Teaches the black magic Stone V
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(163)
end

item_object.onItemUse = function(target)
    target:addSpell(163)
end

return item_object
