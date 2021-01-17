-----------------------------------------
-- ID: 4686
-- Scroll of Barvirus
-- Teaches the white magic Barvirus
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(78)
end

item_object.onItemUse = function(target)
    target:addSpell(78)
end

return item_object
