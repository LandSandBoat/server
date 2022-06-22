-----------------------------------
-- ID: 4920
-- Scroll of Aerora
-- Teaches the black magic Aerora
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(832)
end

item_object.onItemUse = function(target)
    target:addSpell(832)
end

return item_object
