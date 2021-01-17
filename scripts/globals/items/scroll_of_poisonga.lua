-----------------------------------------
-- ID: 4833
-- Scroll of Poisonga
-- Teaches the black magic Poisonga
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(225)
end

item_object.onItemUse = function(target)
    target:addSpell(225)
end

return item_object
