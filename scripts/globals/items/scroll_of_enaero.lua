-----------------------------------------
-- ID: 4710
-- Scroll of Enaero
-- Teaches the white magic Enaero
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(102)
end

item_object.onItemUse = function(target)
    target:addSpell(102)
end

return item_object
