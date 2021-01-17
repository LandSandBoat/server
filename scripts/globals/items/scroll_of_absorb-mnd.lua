-----------------------------------------
-- ID: 4879
-- Scroll of Absorb-MND
-- Teaches the black magic Absorb-MND
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(271)
end

item_object.onItemUse = function(target)
    target:addSpell(271)
end

return item_object
