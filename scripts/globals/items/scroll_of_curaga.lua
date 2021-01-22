-----------------------------------
-- ID: 4615
-- Scroll of Curaga
-- Teaches the white magic Curaga
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(7)
end

item_object.onItemUse = function(target)
    target:addSpell(7)
end

return item_object
