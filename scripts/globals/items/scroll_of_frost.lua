-----------------------------------
-- ID: 4844
-- Scroll of Frost
-- Teaches the black magic Frost
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(236)
end

itemObject.onItemUse = function(target)
    target:addSpell(236)
end

return itemObject
