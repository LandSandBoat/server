-----------------------------------
-- ID: 4858
-- Scroll of Ice Spikes
-- Teaches the black magic Ice Spikes
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(250)
end

itemObject.onItemUse = function(target)
    target:addSpell(250)
end

return itemObject
