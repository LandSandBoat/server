-----------------------------------
-- ID: 5098
-- Scroll of Boost-INT
-- Teaches the white magic Boost-INT
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(483)
end

item_object.onItemUse = function(target)
    target:addSpell(483)
end

return item_object
