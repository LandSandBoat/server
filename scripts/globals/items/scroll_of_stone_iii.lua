-----------------------------------------
-- ID: 4769
-- Scroll of Stone III
-- Teaches the black magic Stone III
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(161)
end

item_object.onItemUse = function(target)
    target:addSpell(161)
end

return item_object
