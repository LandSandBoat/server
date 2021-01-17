-----------------------------------------
-- ID: 4884
-- Scroll of Blind II
-- Teaches the black magic Blind II
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(276)
end

item_object.onItemUse = function(target)
    target:addSpell(276)
end

return item_object
