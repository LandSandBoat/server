-----------------------------------------
-- ID: 4762
-- Scroll of Aero
-- Teaches the black magic Aero
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(154)
end

item_object.onItemUse = function(target)
    target:addSpell(154)
end

return item_object
