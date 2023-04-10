-----------------------------------
-- ID: 4813
-- Scroll of Flare II
-- Teaches the black magic Flare II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(205)
end

itemObject.onItemUse = function(target)
    target:addSpell(205)
end

return itemObject
