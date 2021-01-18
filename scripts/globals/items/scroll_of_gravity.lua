-----------------------------------
-- ID: 4824
-- Scroll of Gravity
-- Teaches the black magic Gravity
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(216)
end

item_object.onItemUse = function(target)
    target:addSpell(216)
end

return item_object
