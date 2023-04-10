-----------------------------------
-- ID: 6571
-- Scroll of Phalanx II
-- Teaches the white magic Phalanx II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(107)
end

itemObject.onItemUse = function(target)
    target:addSpell(107)
end

return itemObject
