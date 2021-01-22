-----------------------------------
-- ID: 6056
-- Voidstorm Schema
-- Teaches the white magic Voidstorm
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(118)
end

item_object.onItemUse = function(target)
    target:addSpell(118)
end

return item_object
