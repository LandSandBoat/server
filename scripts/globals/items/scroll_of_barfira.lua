-----------------------------------
-- ID: 4674
-- Scroll of Barfira
-- Teaches the white magic Barfira
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(66)
end

item_object.onItemUse = function(target)
    target:addSpell(66)
end

return item_object
