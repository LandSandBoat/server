-----------------------------------
-- ID: 5091
-- Scroll of Gain-INT
-- Teaches the white magic Gain-INT
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(490)
end

item_object.onItemUse = function(target)
    target:addSpell(490)
end

return item_object
