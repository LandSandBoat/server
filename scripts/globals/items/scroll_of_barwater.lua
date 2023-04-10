-----------------------------------
-- ID: 4673
-- Scroll of Barwater
-- Teaches the white magic Barwater
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(65)
end

itemObject.onItemUse = function(target)
    target:addSpell(65)
end

return itemObject
