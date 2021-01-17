-----------------------------------------
-- ID: 4892
-- Scroll of Aeroja
-- Teaches the black magic Aeroja
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(498)
end

item_object.onItemUse = function(target)
    target:addSpell(498)
end

return item_object
