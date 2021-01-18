-----------------------------------
-- ID: 4792
-- Scroll of Aeroga
-- Teaches the black magic Aeroga
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(184)
end

item_object.onItemUse = function(target)
    target:addSpell(184)
end

return item_object
