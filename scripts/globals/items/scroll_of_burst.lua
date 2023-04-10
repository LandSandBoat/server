-----------------------------------
-- ID: 4820
-- Scroll of Burst
-- Teaches the black magic Burst
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(212)
end

itemObject.onItemUse = function(target)
    target:addSpell(212)
end

return itemObject
