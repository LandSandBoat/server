-----------------------------------
-- ID: 4674
-- Scroll of Barfira
-- Teaches the white magic Barfira
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(66)
end

itemObject.onItemUse = function(target)
    target:addSpell(66)
end

return itemObject
