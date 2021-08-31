-----------------------------------
-- ID: 4839
-- Scroll of Bio II
-- Teaches the black magic Bio II
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(231)
end

item_object.onItemUse = function(target)
    target:addSpell(231)
end

return item_object
