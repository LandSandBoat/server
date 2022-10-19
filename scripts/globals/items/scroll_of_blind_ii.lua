-----------------------------------
-- ID: 4884
-- Scroll of Blind II
-- Teaches the black magic Blind II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(276)
end

itemObject.onItemUse = function(target)
    target:addSpell(276)
end

return itemObject
