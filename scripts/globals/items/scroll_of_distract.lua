-----------------------------------
-- ID: 4912
-- Scroll of Distract
-- Teaches the black magic Distract
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(841)
end

item_object.onItemUse = function(target)
    target:addSpell(841)
end

return item_object
