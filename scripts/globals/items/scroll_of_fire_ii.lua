-----------------------------------
-- ID: 4753
-- Scroll of Fire II
-- Teaches the black magic Fire II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(145)
end

itemObject.onItemUse = function(target)
    target:addSpell(145)
end

return itemObject
