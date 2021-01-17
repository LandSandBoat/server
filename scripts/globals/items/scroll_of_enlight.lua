-----------------------------------------
-- ID: 4706
-- Scroll of Enlight
-- Teaches the white magic Enlight
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(310)
end

item_object.onItemUse = function(target)
    target:addSpell(310)
end

return item_object
