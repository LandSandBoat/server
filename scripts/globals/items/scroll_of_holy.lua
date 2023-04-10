-----------------------------------
-- ID: 4629
-- Scroll of Holy
-- Teaches the white magic Holy
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(21)
end

itemObject.onItemUse = function(target)
    target:addSpell(21)
end

return itemObject
