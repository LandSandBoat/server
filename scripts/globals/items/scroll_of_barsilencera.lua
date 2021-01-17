-----------------------------------------
-- ID: 4698
-- Scroll of Barsilencera
-- Teaches the white magic Barsilencera
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(90)
end

item_object.onItemUse = function(target)
    target:addSpell(90)
end

return item_object
