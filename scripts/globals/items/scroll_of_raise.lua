-----------------------------------
-- ID: 4620
-- Scroll of Raise
-- Teaches the white magic Raise
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(12)
end

item_object.onItemUse = function(target)
    target:addSpell(12)
end

return item_object
