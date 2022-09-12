-----------------------------------
-- ID: 5106
-- Scroll of Inundation
-- Teaches the white Inundation
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(879)
end

item_object.onItemUse = function(target)
    target:addSpell(879)
end

return item_object
