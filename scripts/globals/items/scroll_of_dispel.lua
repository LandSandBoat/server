-----------------------------------------
-- ID: 4868
-- Scroll of Dispel
-- Teaches the black magic Dispel
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(260)
end

item_object.onItemUse = function(target)
    target:addSpell(260)
end

return item_object
