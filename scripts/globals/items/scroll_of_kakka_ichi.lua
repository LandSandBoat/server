-----------------------------------
-- ID: 4968
-- Scroll of Kakka: Ichi
-- Teaches the ninjutsu Kakka: Ichi
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(509)
end

item_object.onItemUse = function(target)
    target:addSpell(509)
end

return item_object
