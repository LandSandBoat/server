-----------------------------------------
-- ID: 4858
-- Scroll of Ice Spikes
-- Teaches the black magic Ice Spikes
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(250)
end

item_object.onItemUse = function(target)
    target:addSpell(250)
end

return item_object
