-----------------------------------
-- ID: 5097
-- Scroll of Boost-AGI
-- Teaches the white magic Boost-AGI
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(482)
end

item_object.onItemUse = function(target)
    target:addSpell(482)
end

return item_object
