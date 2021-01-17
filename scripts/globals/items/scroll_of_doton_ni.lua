-----------------------------------------
-- ID: 4938
-- Scroll of Doton: ni
-- Teaches the ninjutsu Doton: ni
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(330)
end

item_object.onItemUse = function(target)
    target:addSpell(330)
end

return item_object
