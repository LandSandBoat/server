-----------------------------------
-- ID: 4665
-- Scroll of Haste
-- Teaches the white magic Haste
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(57)
end

item_object.onItemUse = function(target)
    target:addSpell(57)
end

return item_object
