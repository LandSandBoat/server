-----------------------------------
-- ID: 4697
-- Scroll of Barblindra
-- Teaches the white magic Barblindra
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(89)
end

itemObject.onItemUse = function(target)
    target:addSpell(89)
end

return itemObject
