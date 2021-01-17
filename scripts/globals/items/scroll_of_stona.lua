-----------------------------------------
-- ID: 4626
-- Scroll of Stona
-- Teaches the white magic Stona
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(18)
end

item_object.onItemUse = function(target)
    target:addSpell(18)
end

return item_object
