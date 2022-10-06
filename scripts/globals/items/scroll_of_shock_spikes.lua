-----------------------------------
-- ID: 4859
-- Scroll of Shock Spikes
-- Teaches the black magic Shock Spikes
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(251)
end

itemObject.onItemUse = function(target)
    target:addSpell(251)
end

return itemObject
