-----------------------------------
-- ID: 4673
-- Scroll of Barwater
-- Teaches the white magic Barwater
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(65)
end

item_object.onItemUse = function(target)
    target:addSpell(65)
end

return item_object
