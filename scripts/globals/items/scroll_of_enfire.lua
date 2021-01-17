-----------------------------------------
-- ID: 4708
-- Scroll of Enfire
-- Teaches the white magic Enfire
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(100)
end

item_object.onItemUse = function(target)
    target:addSpell(100)
end

return item_object
