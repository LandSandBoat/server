-----------------------------------
-- ID: 4611
-- Scroll of Cure III
-- Teaches the white magic Cure III
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(3)
end

item_object.onItemUse = function(target)
    target:addSpell(3)
end

return item_object
