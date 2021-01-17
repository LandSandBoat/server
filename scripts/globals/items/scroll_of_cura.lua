-----------------------------------------
-- ID: 4701
-- Scroll of Cura
-- Teaches the white magic Cura
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(93)
end

item_object.onItemUse = function(target)
    target:addSpell(93)
end

return item_object
