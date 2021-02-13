-----------------------------------
-- ID: 4777
-- Scroll of Water
-- Teaches the black magic Water
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(169)
end

item_object.onItemUse = function(target)
    target:addSpell(169)
end

return item_object
