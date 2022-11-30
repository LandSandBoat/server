-----------------------------------
-- ID: 4694
-- Scroll of Barsleepra
-- Teaches the white magic Barsleepra
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(86)
end

itemObject.onItemUse = function(target)
    target:addSpell(86)
end

return itemObject
