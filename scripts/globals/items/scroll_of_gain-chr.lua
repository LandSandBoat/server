-----------------------------------
-- ID: 5093
-- Scroll of Gain-CHR
-- Teaches the white magic Gain-CHR
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(492)
end

itemObject.onItemUse = function(target)
    target:addSpell(492)
end

return itemObject
