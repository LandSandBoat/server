-----------------------------------------
-- ID: 4877
-- Scroll of Absorb-AGI
-- Teaches the black magic Absorb-AGI
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(269)
end

item_object.onItemUse = function(target)
    target:addSpell(269)
end

return item_object
