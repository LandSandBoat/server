-----------------------------------
-- ID: 4876
-- Scroll of Absorb-VIT
-- Teaches the black magic Absorb-VIT
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(268)
end

itemObject.onItemUse = function(target)
    target:addSpell(268)
end

return itemObject
