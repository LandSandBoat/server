-----------------------------------
-- ID: 4857
-- Scroll of Blaze Spikes
-- Teaches the black magic Blaze Spikes
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(249)
end

itemObject.onItemUse = function(target)
    target:addSpell(249)
end

return itemObject
