-----------------------------------
-- ID: 4885
-- Scroll of Dread Spikes
-- Teaches the black magic Dread Spikes
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(277)
end

itemObject.onItemUse = function(target)
    target:addSpell(277)
end

return itemObject
