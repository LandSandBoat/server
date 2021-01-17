-----------------------------------------
-- ID: 4733
-- Scroll of Protectra
-- Teaches the white magic Protectra
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(125)
end

item_object.onItemUse = function(target)
    target:addSpell(125)
end

return item_object
