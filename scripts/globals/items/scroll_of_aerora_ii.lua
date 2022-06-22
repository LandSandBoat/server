-----------------------------------
-- ID: 4921
-- Scroll of Aerora II
-- Teaches the black magic Aerora II
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(833)
end

item_object.onItemUse = function(target)
    target:addSpell(833)
end

return item_object
