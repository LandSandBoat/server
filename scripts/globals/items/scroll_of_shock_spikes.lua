-----------------------------------------
-- ID: 4859
-- Scroll of Shock Spikes
-- Teaches the black magic Shock Spikes
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(251)
end

item_object.onItemUse = function(target)
    target:addSpell(251)
end

return item_object
