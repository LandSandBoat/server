-----------------------------------------
-- ID: 4846
-- Scroll of Rasp
-- Teaches the black magic Rasp
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(238)
end

item_object.onItemUse = function(target)
    target:addSpell(238)
end

return item_object
