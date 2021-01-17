-----------------------------------------
-- ID: 4623
-- Scroll of Paralyna
-- Teaches the white magic Paralyna
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(15)
end

item_object.onItemUse = function(target)
    target:addSpell(15)
end

return item_object
