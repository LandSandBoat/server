-----------------------------------
-- ID: 4618
-- Scroll of Curaga IV
-- Teaches the white magic Curaga IV
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(10)
end

item_object.onItemUse = function(target)
    target:addSpell(10)
end

return item_object
