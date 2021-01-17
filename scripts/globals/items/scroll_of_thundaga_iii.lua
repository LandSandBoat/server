-----------------------------------------
-- ID: 4804
-- Scroll of Thundaga III
-- Teaches the black magic Thundaga III
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(196)
end

item_object.onItemUse = function(target)
    target:addSpell(196)
end

return item_object
