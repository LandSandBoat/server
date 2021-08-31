-----------------------------------
-- ID: 4699
-- Scroll of Barpetra
-- Teaches the white magic Barpetra
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(91)
end

item_object.onItemUse = function(target)
    target:addSpell(91)
end

return item_object
