-----------------------------------
-- ID: 4813
-- Scroll of Flare II
-- Teaches the black magic Flare II
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(205)
end

item_object.onItemUse = function(target)
    target:addSpell(205)
end

return item_object
