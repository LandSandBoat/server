-----------------------------------
-- ID: 4688
-- Scroll of Recall-Pashh
-- Teaches the white magic Recall-Pashh
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(82)
end

itemObject.onItemUse = function(target)
    target:addSpell(82)
end

return itemObject
