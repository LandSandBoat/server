-----------------------------------
-- ID: 4619
-- Scroll of Curaga V
-- Teaches the white magic Curaga V
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(11)
end

item_object.onItemUse = function(target)
    target:addSpell(11)
end

return item_object
