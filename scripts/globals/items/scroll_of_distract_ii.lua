-----------------------------------------
-- ID: 4913
-- Scroll of Distract
-- Teaches the black magic Distract II
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(842)
end

item_object.onItemUse = function(target)
    target:addSpell(842)
end

return item_object
