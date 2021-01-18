-----------------------------------
-- ID: 4748
-- Scroll of Raise II
-- Teaches the white magic Raise III
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(140)
end

item_object.onItemUse = function(target)
    target:addSpell(140)
end

return item_object
