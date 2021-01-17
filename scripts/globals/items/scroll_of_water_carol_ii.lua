-----------------------------------------
-- ID: 5059
-- Scroll of Water Carol II
-- Teaches the song Water Carol II
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(451)
end

item_object.onItemUse = function(target)
    target:addSpell(451)
end

return item_object
