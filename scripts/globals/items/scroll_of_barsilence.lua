-----------------------------------
-- ID: 4684
-- Scroll of Barsilence
-- Teaches the white magic Barsilence
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(76)
end

item_object.onItemUse = function(target)
    target:addSpell(76)
end

return item_object
