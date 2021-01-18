-----------------------------------
-- ID: 4876
-- Scroll of Absorb-VIT
-- Teaches the black magic Absorb-VIT
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(268)
end

item_object.onItemUse = function(target)
    target:addSpell(268)
end

return item_object
