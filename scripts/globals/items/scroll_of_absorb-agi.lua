-----------------------------------
-- ID: 4877
-- Scroll of Absorb-AGI
-- Teaches the black magic Absorb-AGI
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(269)
end

itemObject.onItemUse = function(target)
    target:addSpell(269)
end

return itemObject
