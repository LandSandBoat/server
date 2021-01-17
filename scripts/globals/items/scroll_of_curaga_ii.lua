-----------------------------------------
-- ID: 4616
-- Scroll of Curaga II
-- Teaches the white magic Curaga II
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(8)
end

item_object.onItemUse = function(target)
    target:addSpell(8)
end

return item_object
