-----------------------------------------
-- ID: 4914
-- Scroll of Frazzle
-- Teaches the black magic Frazzle
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(843)
end

item_object.onItemUse = function(target)
    target:addSpell(843)
end

return item_object
