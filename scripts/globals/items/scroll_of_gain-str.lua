-----------------------------------
-- ID: 5087
-- Scroll of Gain-STR
-- Teaches the white magic Gain-STR
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(486)
end

itemObject.onItemUse = function(target)
    target:addSpell(486)
end

return itemObject
