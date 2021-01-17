-----------------------------------------
-- ID: 4726
-- Scroll of Enthunder II
-- Teaches the white magic Enthunder II
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(316)
end

item_object.onItemUse = function(target)
    target:addSpell(316)
end

return item_object
