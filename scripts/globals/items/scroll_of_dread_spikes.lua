-----------------------------------
-- ID: 4885
-- Scroll of Dread Spikes
-- Teaches the black magic Dread Spikes
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(277)
end

item_object.onItemUse = function(target)
    target:addSpell(277)
end

return item_object
