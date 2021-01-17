-----------------------------------------
-- ID: 4848
-- Scroll of Drown
-- Teaches the black magic Drown
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(240)
end

item_object.onItemUse = function(target)
    target:addSpell(240)
end

return item_object
