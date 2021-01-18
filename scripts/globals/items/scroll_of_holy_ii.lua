-----------------------------------
-- ID: 4629
-- Scroll of Holy II
-- Teaches the white magic Holy II
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(22)
end

item_object.onItemUse = function(target)
    target:addSpell(22)
end

return item_object
