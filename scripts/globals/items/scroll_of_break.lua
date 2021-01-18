-----------------------------------
-- ID: 4863
-- Scroll of Break
-- Teaches the black magic Break
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(255)
end

item_object.onItemUse = function(target)
    target:addSpell(255)
end

return item_object
