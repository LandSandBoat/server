-----------------------------------------
-- ID: 4857
-- Scroll of Blaze Spikes
-- Teaches the black magic Blaze Spikes
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(249)
end

item_object.onItemUse = function(target)
    target:addSpell(249)
end

return item_object
