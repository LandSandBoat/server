-----------------------------------
-- ID: 4685
-- Scroll of Barpetrify
-- Teaches the white magic Barpetrify
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(77)
end

item_object.onItemUse = function(target)
    target:addSpell(77)
end

return item_object
