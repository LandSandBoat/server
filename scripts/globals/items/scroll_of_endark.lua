-----------------------------------
-- ID: 4707
-- Scroll of Endark
-- Teaches the white magic Endark
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(311)
end

item_object.onItemUse = function(target)
    target:addSpell(311)
end

return item_object
