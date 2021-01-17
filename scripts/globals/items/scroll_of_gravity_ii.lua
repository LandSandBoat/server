-----------------------------------------
-- ID: 4825
-- Scroll of Gravity II
-- Teaches the black magic Gravity II
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(217)
end

item_object.onItemUse = function(target)
    target:addSpell(217)
end

return item_object
