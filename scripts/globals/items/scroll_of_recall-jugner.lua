-----------------------------------
-- ID: 4687
-- Scroll of Recall-Jugner
-- Teaches the white magic Recall-Jugner
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(81)
end

itemObject.onItemUse = function(target)
    target:addSpell(81)
end

return itemObject
