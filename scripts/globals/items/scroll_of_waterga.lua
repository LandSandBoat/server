-----------------------------------
-- ID: 4807
-- Scroll of Waterga
-- Teaches the black magic Waterga
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(199)
end

item_object.onItemUse = function(target)
    target:addSpell(199)
end

return item_object
