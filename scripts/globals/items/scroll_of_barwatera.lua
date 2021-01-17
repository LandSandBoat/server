-----------------------------------------
-- ID: 4679
-- Scroll of Barwatera
-- Teaches the white magic Barwatera
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(71)
end

item_object.onItemUse = function(target)
    target:addSpell(71)
end

return item_object
