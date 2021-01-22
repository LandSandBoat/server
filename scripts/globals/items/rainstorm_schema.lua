-----------------------------------
-- ID: 6050
-- Rainstorm Schema
-- Teaches the white magic Rainstorm
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(113)
end

item_object.onItemUse = function(target)
    target:addSpell(113)
end

return item_object
