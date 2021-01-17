-----------------------------------------
-- ID: 4690
-- Scroll of Baramnesia
-- Teaches the white magic Baramnesia
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(84)
end

item_object.onItemUse = function(target)
    target:addSpell(84)
end

return item_object
