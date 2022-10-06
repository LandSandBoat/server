-----------------------------------
-- ID: 4863
-- Scroll of Break
-- Teaches the black magic Break
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(255)
end

itemObject.onItemUse = function(target)
    target:addSpell(255)
end

return itemObject
