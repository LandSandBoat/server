-----------------------------------
-- ID: 4709
-- Scroll of Enblizzard
-- Teaches the white magic Enblizzard
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(101)
end

item_object.onItemUse = function(target)
    target:addSpell(101)
end

return item_object
