-----------------------------------
-- ID: 4612
-- Scroll of Cure IV
-- Teaches the white magic Cure IV
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(4)
end

itemObject.onItemUse = function(target)
    target:addSpell(4)
end

return itemObject
