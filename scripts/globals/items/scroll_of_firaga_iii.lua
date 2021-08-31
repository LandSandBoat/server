-----------------------------------
-- ID: 4784
-- Scroll of Firaga III
-- Teaches the black magic Firaga III
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(176)
end

item_object.onItemUse = function(target)
    target:addSpell(176)
end

return item_object
