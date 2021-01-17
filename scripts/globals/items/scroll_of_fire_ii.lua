-----------------------------------------
-- ID: 4753
-- Scroll of Fire II
-- Teaches the black magic Fire II
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(145)
end

item_object.onItemUse = function(target)
    target:addSpell(145)
end

return item_object
