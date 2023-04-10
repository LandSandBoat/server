-----------------------------------
-- ID: 4699
-- Scroll of Barpetra
-- Teaches the white magic Barpetra
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(91)
end

itemObject.onItemUse = function(target)
    target:addSpell(91)
end

return itemObject
