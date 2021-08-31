-----------------------------------
-- ID: 4617
-- Scroll of Curaga III
-- Teaches the white magic Curaga III
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(9)
end

item_object.onItemUse = function(target)
    target:addSpell(9)
end

return item_object
