-----------------------------------
-- ID: 6054
-- Windstorm Schema
-- Teaches the white magic Windstorm
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(114)
end

item_object.onItemUse = function(target)
    target:addSpell(114)
end

return item_object
