-----------------------------------------
-- ID: 5051
-- Scroll of Water Carol
-- Teaches the song Water Carol
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(443)
end

item_object.onItemUse = function(target)
    target:addSpell(443)
end

return item_object
