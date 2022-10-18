-----------------------------------
-- ID: 4883
-- Scroll of Absorb-TP
-- Teaches the black magic Absorb-TP
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(275)
end

itemObject.onItemUse = function(target)
    target:addSpell(275)
end

return itemObject
