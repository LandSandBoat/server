-----------------------------------------
-- ID: 4803
-- Scroll of Thundaga II
-- Teaches the black magic Thundaga II
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(195)
end

item_object.onItemUse = function(target)
    target:addSpell(195)
end

return item_object
