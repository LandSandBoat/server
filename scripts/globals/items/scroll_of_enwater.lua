-----------------------------------
-- ID: 4713
-- Scroll of Enwater
-- Teaches the white magic Enwater
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(105)
end

item_object.onItemUse = function(target)
    target:addSpell(105)
end

return item_object
