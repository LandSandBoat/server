-----------------------------------------
-- ID: 4740
-- Scroll of Shellra III
-- Teaches the white magic Shellra III
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(132)
end

item_object.onItemUse = function(target)
    target:addSpell(132)
end

return item_object
