-----------------------------------
-- ID: 4694
-- Scroll of Barsleepra
-- Teaches the white magic Barsleepra
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(86)
end

item_object.onItemUse = function(target)
    target:addSpell(86)
end

return item_object
