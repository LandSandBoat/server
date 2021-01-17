-----------------------------------------
-- ID: 4781
-- Scroll of Water V
-- Teaches the black magic Water V
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(173)
end

item_object.onItemUse = function(target)
    target:addSpell(173)
end

return item_object
