-----------------------------------------
-- ID: 4773
-- Scroll of Thunder II
-- Teaches the black magic Thunder II
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(165)
end

item_object.onItemUse = function(target)
    target:addSpell(165)
end

return item_object
