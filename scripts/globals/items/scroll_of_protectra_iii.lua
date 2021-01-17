-----------------------------------------
-- ID: 4735
-- Scroll of Protectra III
-- Teaches the white magic Protectra III
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(127)
end

item_object.onItemUse = function(target)
    target:addSpell(127)
end

return item_object
