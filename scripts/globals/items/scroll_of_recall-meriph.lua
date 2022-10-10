-----------------------------------
-- ID: 4689
-- Scroll of Recall-Meriph
-- Teaches the white magic Recall-Meriph
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(83)
end

itemObject.onItemUse = function(target)
    target:addSpell(83)
end

return itemObject
