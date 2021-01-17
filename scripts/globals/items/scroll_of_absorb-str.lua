-----------------------------------------
-- ID: 4874
-- Scroll of Absorb-STR
-- Teaches the black magic Absorb-STR
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(266)
end

item_object.onItemUse = function(target)
    target:addSpell(266)
end

return item_object
