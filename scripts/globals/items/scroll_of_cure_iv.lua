-----------------------------------------
-- ID: 4612
-- Scroll of Cure IV
-- Teaches the white magic Cure IV
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(4)
end

item_object.onItemUse = function(target)
    target:addSpell(4)
end

return item_object
